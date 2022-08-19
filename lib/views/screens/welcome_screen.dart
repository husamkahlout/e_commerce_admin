import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Category/categories_screen.dart';
import 'package:e_commerce/views/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  navigateFunction() async {
    await Future.delayed(const Duration(seconds: 3));
    Provider.of<AuthProvider>(AppRouter.navKey.currentContext!, listen: false).checkUser();
  }

  @override
  Widget build(BuildContext context) {
    navigateFunction();
    return const Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: MobileWelcomeScreen(),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            const SizedBox(height: 5),
            // Text(
            //   "E-Commerce App",
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // SizedBox(height: defaultPadding * 2),
            Center(
              child: Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SvgPicture.asset(
                      "assets/icons/chat.svg",
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
          ],
        ),
        // Row(
        //   children: [
        //     const Spacer(),
        //     Expanded(
        //       flex: 8,
        //       child: Column(
        //         children: [
        //           Hero(
        //             tag: "admin_btn",
        //             child: ElevatedButton(
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) {
        //                       return CategoriesScreen();
        //                     },
        //                   ),
        //                 );
        //               },
        //               child:  Text(
        //                 "Admin".toUpperCase(),
        //               ),
        //             ),
        //           ),
        //           const SizedBox(height: 16),
        //           ElevatedButton(
        //             onPressed: () {
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) {
        //                     return UserCategories();
        //                   },
        //                 ),
        //               );
        //             },
        //             style: ElevatedButton.styleFrom(
        //                 primary: kPrimaryLightColor, elevation: 0),
        //             child: Text(
        //               "User".toUpperCase(),
        //               style: TextStyle(color: Colors.black),
        //             ),
        //           ),
        //           const SizedBox(height: 30),
        //         ],
        //       ),
        //     ),
        //     Spacer(),
        //   ],
        // ),
      ],
    );
  }
}
