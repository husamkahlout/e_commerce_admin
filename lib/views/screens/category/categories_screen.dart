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
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => AddCategory())));
          },
          elevation: 15,
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add_rounded),
        ),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text("Categories"),
          actions: [
            IconButton(
              onPressed: () {
                authProvider.signOut();
              },
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
        body: firestoreProvider.categories.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: firestoreProvider.categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      firestoreProvider.getAllProduct(
                          firestoreProvider.categories[index].categoryId!);

                      // AppRouter.NavigateToWidget(ProductsScreen(
                      //     firestoreProvider.categories[index].categoryId!));

                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => ProductsScreen(
                              firestoreProvider
                                  .categories[index].categoryId!))));
                    },
                    child: CategoryWidget(
                        category: firestoreProvider.categories[index]),
                  );
                },
              ),
      );
    });
  }
}
