import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Product/all_products.dart';
import 'package:e_commerce/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProduct extends StatelessWidget {
  Product product;
  String catId;
  UpdateProduct({required this.product, required this.catId});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, FirestoreProvider>(
        builder: (context, authProvider, firestoreProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
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
                                  backgroundImage: NetworkImage(product.image),
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
                            customHintText: "Product name",
                            textFieldValidator: authProvider.nullValidation,
                            textFieldController:
                                firestoreProvider.productNameController,
                            prefixIcon: const Icon(Icons.category_rounded),
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
                            textFieldController:
                                firestoreProvider.productPriceController,
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
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              product.name = Provider.of<FirestoreProvider>(
                                      context,
                                      listen: false)
                                  .productNameController
                                  .text;
                              product.description =
                                  Provider.of<FirestoreProvider>(context,
                                          listen: false)
                                      .productDescriptionController
                                      .text;
                              Provider.of<FirestoreProvider>(context,
                                      listen: false)
                                  .productPriceController
                                  .text = product.price.toString();
                              Provider.of<FirestoreProvider>(context,
                                      listen: false)
                                  .productQuantityController
                                  .text = product.quantitiy.toString();
                              firestoreProvider.updateProduct(product, catId);
                              // Navigator.pop(context);
                            },
                            child: const Text("Update Product")),
                        const SizedBox(
                          height: 20,
                        ),
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
