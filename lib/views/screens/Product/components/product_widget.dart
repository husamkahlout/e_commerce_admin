import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Product/update_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  String catId;
  ProductWidget({required this.product, required this.catId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
//=========================Product Card ========================//
        Container(
          // padding: EdgeInsets.only(bottom: 20),
          margin: EdgeInsets.only(bottom: 20),
          width: 300,
          decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              //  const SizedBox(
              //     height: 10,
              //   ),
              //========== Image ===========//
              Container(
                height: 135,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(product.image), fit: BoxFit.cover)),
              ),
              //=============== Details ======================//
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(color: kPrimaryColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //=============================== Price  ==================================//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              r'$ ',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              product.price.toString(),
                              style: const TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),

                        Consumer<FirestoreProvider>(
                            builder: (context, firestoreProvider, x) {
                          return Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      firestoreProvider.productNameController.text = product.name;
                                      firestoreProvider.productDescriptionController.text = product.description;
                                      firestoreProvider.productPriceController.text = product.price.toString();
                                      firestoreProvider.productQuantityController.text = product.quantitiy.toString();
                                      AppRouter.NavigateToWidget(UpdateProduct(
                                          product: product, catId: catId));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )),
                              SizedBox(
                                width: 9,
                              ),
                              Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(
                                    onTap: () => firestoreProvider
                                        .deleteProduct(product, catId),
                                    child: const Icon(
                                      Icons.delete_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )),
                            ],
                          );
                        })
                        //========== Add Icon  ===========//
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));

    // return Container(
    //   child: Column(
    //     children: [
    //       SizedBox(
    //           height: 200,
    //           width: double.infinity,
    //           child: Image.network(
    //             product.image,
    //             fit: BoxFit.cover,
    //           )),
    //       const SizedBox(
    //         height: 5,
    //       ),
    //       Container(
    //         margin: const EdgeInsets.symmetric(horizontal: 50),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               product.name,
    //               style: const TextStyle(
    //                 color: kPrimaryColor,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Row(
    //               children: [
    //                 IconButton(
    //                     onPressed: () {
    //                       Provider.of<FirestoreProvider>(context, listen: false)
    //                           .productNameController
    //                           .text = product.name;
    //                       // AppRouter.NavigateWithReplacementToWidget(UpdateCategory(category: category));
    //                       Navigator.of(context).pushReplacement(
    //                           MaterialPageRoute(
    //                               builder: ((context) => UpdateProduct(
    //                                   product: product, catId: catId))));
    //                     },
    //                     color: kPrimaryColor,
    //                     icon: Icon(Icons.edit)),
    //                 const SizedBox(
    //                   width: 10,
    //                 ),
    //                 IconButton(
    //                     onPressed: () {
    //                       Provider.of<FirestoreProvider>(context, listen: false)
    //                           .deleteProduct(product, catId);
    //                     },
    //                     color: kPrimaryColor,
    //                     icon: const Icon(Icons.delete_rounded)),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
