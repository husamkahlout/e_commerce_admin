
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Product/update_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  String catId;
  ProductWidget({required this.product,required this.catId,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                   style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                  ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Provider.of<FirestoreProvider>(context, listen: false).productNameController.text = product.name;
                          // AppRouter.NavigateWithReplacementToWidget(UpdateCategory(category: category));
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => UpdateProduct(product: product,catId: catId))));
                        },
                        color: kPrimaryColor,
                        icon: Icon(Icons.edit)),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              Provider.of<FirestoreProvider>(context, listen: false)
                                  .deleteProduct(product,catId);
                            },
                            color: kPrimaryColor,
                            icon: const Icon(Icons.delete_rounded)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       SizedBox(
  //           height: 200,
  //           width: double.infinity,
  //           child: Image.network(product.image,fit: BoxFit.cover,)),
  //       const SizedBox(height: 5,),
  //       Row(
  //         children: [
  //           Text(product.name),
  //           const SizedBox(width: 10,),
  //           Expanded(
  //             child: TextButton(onPressed: (){
  //               Provider.of<FirestoreProvider>(context,listen:false).productNameController.text=product.name;
  //               Provider.of<FirestoreProvider>(context,listen:false).productDescriptionController.text=product.description;
  //               Provider.of<FirestoreProvider>(context,listen:false).productPriceController.text=product.price.toString();
  //               Provider.of<FirestoreProvider>(context,listen:false).productQuantityController.text=product.quantitiy.toString();
  //               // AppRouter.NavigateToWidget(UpdateProduct(product: product,id: catId));
  //             }, child: const Text('update')),
  //           ),
  //          const SizedBox(width: 10,),
  //           IconButton(onPressed: (){
  //             Provider.of<FirestoreProvider>(context,listen:false).deleteProduct(product,catId);

  //           }, icon: const Icon(Icons.delete)),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}