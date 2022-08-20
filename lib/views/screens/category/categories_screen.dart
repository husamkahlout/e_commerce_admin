import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Product/all_products.dart';
import 'package:e_commerce/views/screens/category/add_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/firestore_provider.dart';
import 'components/category_widget.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, x) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // AppRouter.NavigateWithReplacementToWidget(AddCategory());
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => AddCategory())));
            },
            elevation: 15,
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.add_rounded),
          ),
          body: SafeArea(
              child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(18),
                  children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 620,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///============================== Menu ====================================///
                              InkWell(
                                onTap: () => authProvider.signOut(),
                                child: Container(
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
                                  backgroundImage:
                                      AssetImage("assets/images/husam.png"),
                                ),
                              )
                            ],
                          ),

                          //============================== Main Text ====================================///
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Find the best\nproduct for you",
                            style: TextStyle(
                              letterSpacing: 1.1,
                              color: kPrimaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //============================== TextField ====================================///
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 6.8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "find your product...",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 89, 47, 111),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon:
                                    Icon(Icons.search, color: kPrimaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Choose category',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          firestoreProvider.categories.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : Column(
                                  children: List.generate(
                                      firestoreProvider.categories.length,
                                      (index) {
                                    return InkWell(
                                      onTap: () {
                                        firestoreProvider.getAllProduct(
                                            firestoreProvider
                                                .categories[index].categoryId!);
                                        AppRouter.NavigateToWidget(
                                            ProductsScreen(firestoreProvider
                                                .categories[index]
                                                .categoryId!));
                                      },
                                      child: CategoryWidget(
                                          category: firestoreProvider
                                              .categories[index]),
                                    );
                                  }),
                                ),
                        ]),
                  ),
                )
              ])));
    });
  }
}
