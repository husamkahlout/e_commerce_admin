import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/appUser.dart';
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/models/product.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final String categoriesCollectionName = "categories";
  final String usersCollectionName = "users";

  CollectionReference<Map<String, dynamic>> categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  // firestoreInstance.collection("collectionName").add(document) => document = map
  // the id of documents generated after create the document
  /* add named id to the document you will add 
      
      if its exits => edit it , 
      if not exits => create it 
      .collection(usersCollectionName).doc("id") // will give credinial id from firebase aut.set({});

         /* add document without named id , firebase will choose one */

    // await firestoreInstance.collection("users").add({
    //   'userName': userName,
    //   'email': email,
    //   'id': id,
    //   'phone' :phone,
    // });
  */

  // ======================================== Users =========================================================
  addUserToFirestore(AppUser appUser) async {
    await firestoreInstance
        .collection(usersCollectionName)
        .doc(appUser.id) // will give credinial id from firebase auth
        .set(appUser.toMap());
  }

  Future<AppUser> getUserFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestoreInstance.collection(usersCollectionName).doc(id).get();
    log(documentSnapshot.data().toString());
    return AppUser.fromMap(documentSnapshot.data()!);
  }

  // ======================================== Categories =========================================================

  addNewCategory(Category category) async {
    await firestoreInstance
        .collection(categoriesCollectionName)
        .add(category.toMap());
  }

  Future<List<Category>> getAllCategories() async {
    // get will return all documnets in the categories collection
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestoreInstance.collection(categoriesCollectionName).get();
    //  list of documents
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
    // convert list of documents to list of categories

    /*  
    type of element is QueryDocumentSnapshot which have metadata about the real data you will fetch from firebase
    the id is one of the metadata the firebase add it you will recieve from metadata
    ===>>> element.id <<<<<====
     */
    List<Category> categories = documents.map((element) {
      // Category.fromMap(e.data()) ==> will fetch the realdata from firebase {name ,imageUrl}
      Category category = Category.fromMap(element.data());
      // element.id ==> will fetch id from the metadata firebase created it
      category.categoryId = element.id;
      return category;
    }).toList();
    log(categories.toString());
    return categories;
  }

  deleteCategory(Category category) async {
    await firestoreInstance
        .collection(categoriesCollectionName)
        .doc(category.categoryId)
        .delete();
  }

  updateCategory(Category category) async {
    await firestoreInstance
        .collection(categoriesCollectionName)
        .doc(category.categoryId)
        .update(category.toMap());
  }

  // ======================================== Products =========================================================

  Future<Product> addNewProduct(Product product, String categoryId) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await categoriesCollection
            .doc(categoryId)
            .collection('products')
            .add(product.toMap());
    product.id = documentReference.id;
    return product;
  }

  Future<List<Product>> getAllProduct(String categoryId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await categoriesCollection.doc(categoryId).collection('products').get();
    List<Product> products = querySnapshot.docs.map((e) {
      Map<String, dynamic> data = e.data();
      data['id'] = e.id;
      Product product = Product.fromMap(data);
      product.id = e.id;
      return product;
    }).toList();
    return products;
  }

  updateProduct(Product product, String categoryId) async {
    await categoriesCollection
        .doc(categoryId)
        .collection('products')
        .doc(product.id)
        .update(product.toMap());
  }

  deleteProduct(Product product, String categoryId) async {
    await categoriesCollection
        .doc(categoryId)
        .collection('products')
        .doc(product.id)
        .delete();
  }
}
