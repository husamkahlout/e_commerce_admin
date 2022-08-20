import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/models/product.dart';
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
  ProductsScreen(this.catId);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, x) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => AddProduct(catId))));
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: ListView(
              shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(18),
            children : [
              Container(
                width:MediaQuery.of(context).size.width,
              height: 620,
                child: SingleChildScrollView(
                  child: Column(
                      // padding: const EdgeInsets.all(18),
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///============================== Menu ====================================///
                      Container(
                        child: const Icon(
                          Icons.grid_view_rounded,
                          size: 25,
                          color: kPrimaryColor,
                        ),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                            
                      ///============================== Profile Image ====================================///
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/husam.png"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  firestoreProvider.products.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children:
                              List.generate(firestoreProvider.products.length, (index) {
                          return ProductWidget(
                              product: firestoreProvider.products[index], catId: catId);
                        })),
                            ]),
                ),
              ), 
              ] 
          ),
        ),
      );
    });
  }
}
