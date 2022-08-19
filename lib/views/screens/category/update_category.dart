import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Category/categories_screen.dart';
import 'package:e_commerce/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCategory extends StatelessWidget {
  Category category;

  UpdateCategory({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit Category"),
          backgroundColor: kPrimaryColor,
          actions: [
            IconButton(
              onPressed: () {
                authProvider.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            firestoreProvider.selectImage();
                          },
                          child: firestoreProvider.selectedImage == null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: kPrimaryColor,
                                  backgroundImage:
                                      NetworkImage(category.imageUrl),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(
                                      firestoreProvider.selectedImage!),
                                ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            customHintText: "Category name",
                            textFieldValidator:
                                firestoreProvider.nullValidation,
                            textFieldController:
                                firestoreProvider.categoryNameController,
                            prefixIcon: const Icon(Icons.category_rounded),
                            isSecure: false,
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              firestoreProvider.updateCategory(category);
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: ((context) =>
                              //             CategoriesScreen())));
                            },
                            child: const Text("Update Category")),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                          firestoreProvider.getAllCategories();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => CategoriesScreen())));

                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(kPrimaryColor),
                                ),
                                child: const Text("View Categories >")),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
