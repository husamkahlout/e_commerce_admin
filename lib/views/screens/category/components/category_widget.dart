
import 'package:e_commerce/models/category.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Category/update_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                category.imageUrl,
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
                  category.name,
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
                          Provider.of<FirestoreProvider>(context, listen: false).categoryNameController.text = category.name;
                          // AppRouter.NavigateWithReplacemtnToWidget(UpdateCategory(category: category));
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => UpdateCategory(category: category))));
                            
                        },
                        color: kPrimaryColor,
                        icon: Icon(Icons.edit)),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              Provider.of<FirestoreProvider>(context, listen: false)
                                  .deleteCategory(category);
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
}
