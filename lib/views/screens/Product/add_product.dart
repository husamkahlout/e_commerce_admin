import 'dart:io';

import 'package:e_commerce/firebase/storage_helper.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Category/categories_screen.dart';
import 'package:e_commerce/views/screens/Product/all_products.dart';
import 'package:e_commerce/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  String catId;
   AddProduct(this.catId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, child) {
          return Scaffold(
            appBar: AppBar(
               title: const Text("Add product"),
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
            body: Center(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              firestoreProvider.selectImage();
                            },
                            child: firestoreProvider.selectedImage == null
                                ? const CircleAvatar(
                              radius: 50,
                              
                              backgroundColor: kPrimaryColor,
                              child: Icon(Icons.add_a_photo_rounded, color: Colors.white,size: 30,),
                            )
                                : CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              FileImage(firestoreProvider.selectedImage!),
                            ),
                          ),
                          SizedBox(height: 20,),
                            CustomTextField(
                                  customHintText: "Product name",
                                  textFieldValidator: authProvider.nullValidation,
                                  textFieldController: firestoreProvider.productNameController,
                                  prefixIcon: Icon(Icons.category_rounded),
                                  isSecure: false,
                                  textInputType: TextInputType.text),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: CustomTextField(
                                  customHintText: "Product description",
                                  textFieldValidator: authProvider.nullValidation,
                                  textFieldController:
                                     firestoreProvider.productDescriptionController,
                                  prefixIcon: Icon(Icons.description),
                                  textInputType: TextInputType.text,
                                  isSecure: false,
                                ),
                              ),
                                CustomTextField(
                          customHintText: "Product price",
                          textFieldValidator: authProvider.nullValidation,
                          textFieldController: firestoreProvider.productPriceController,
                          prefixIcon: Icon(Icons.attach_money_rounded),
                          isSecure: false,
                          textInputType: TextInputType.number),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: CustomTextField(
                          customHintText: "Product quantity",
                          textFieldValidator: authProvider.nullValidation,
                          textFieldController:
                              firestoreProvider.productQuantityController,
                          prefixIcon: Icon(Icons.production_quantity_limits),
                          textInputType: TextInputType.number,
                          isSecure: false,
                        ),
                      ),
                      const SizedBox(height: 20,),
                          ElevatedButton(
                            onPressed: () async {
                              firestoreProvider.addNewProduct(catId);
                            },
                            child: Text('Add New Product'),
                          ),
                          SizedBox(height: 15,),
                              Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                firestoreProvider.getAllProduct(catId);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            ProductsScreen(catId))));
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                              ),
                              child: const Text("View Products >")),
                              
                        ],
                      ),
                            SizedBox(height: 20,),
                        ],
                      ),
                    ),
                     const Spacer(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}