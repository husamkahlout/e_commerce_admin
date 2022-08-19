
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Category/categories_screen.dart';
import 'package:e_commerce/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body:
          Consumer<FirestoreProvider>(builder: (context, firestorProvider, x) {
        return SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 30),
            firestorProvider.selectedImage == null
                ? InkWell(
                    onTap: () => firestorProvider.selectImage(),
                    child: const CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      radius: 50,
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () => firestorProvider.selectImage(),
                    child: CircleAvatar(
                      backgroundImage:
                          FileImage(firestorProvider.selectedImage!),
                      radius: 50,
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: firestorProvider.categoryKey,
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          customHintText: "Category name",
                          textFieldValidator: firestorProvider.nullValidation,
                          textFieldController:
                              firestorProvider.categoryNameController,
                          prefixIcon: const Icon(Icons.category_rounded),
                          isSecure: false,
                          textInputType: TextInputType.text),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            firestorProvider.addNewCategory();
                          },
                          child: const Text("Add Category")),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                firestorProvider.getAllCategories();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            CategoriesScreen())));
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                              ),
                              child: const Text("View Categories >")),
                        ],
                      ),
                    ]),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ]),
        );
      }),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextButton(
      //           onPressed: () {
      //             // Provider.of<AuthProvider>(context, listen: false).signIn();
      //           },
      //           child: Text("get User")),
      //       TextButton(
      //           onPressed: () async {
      //             Provider.of<StorageProvider>(context, listen: false)
      //                 .uploadImage();
      //           },
      //           child: Text("Add Image")),
      //     ],
      //   ),
      // ),
    );
  }
}
