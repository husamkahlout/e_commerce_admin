
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Category/categories_screen.dart';
import 'package:e_commerce/views/screens/Product/add_product.dart';
import 'package:e_commerce/views/screens/Product/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  String catId;
   ProductsScreen(this.catId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, x) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => AddProduct(catId))));
              },
              backgroundColor: kPrimaryColor,
              child: const Icon(Icons.add),
              
            ),
            appBar: AppBar(
              title: const Text("Products"),
              backgroundColor: kPrimaryColor,
              actions: [
                IconButton(
                  onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => CategoriesScreen())));
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: firestoreProvider.products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: firestoreProvider.products.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                  },
                  child: ProductWidget(
                      product: firestoreProvider.products[index],catId: catId),
                );
              },
            ),
          );
        });
  }
}