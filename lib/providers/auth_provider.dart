import 'package:e_commerce/firebase/auth_helper.dart';
import 'package:e_commerce/firebase/firestore_helper.dart';
import 'package:e_commerce/models/appUser.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/screens/Category/categories_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  String? countryCode = '970';

  nullValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "required field";
    }
  }

  String? emailValidation(String? value) {
    if (!isEmail(value!)) {
      return "invalid email";
    }
  }

  String? passwordValidation(String? value) {
    if (value!.length < 6) {
      return "password must contain 6 digits at least";
    }
  }

  String? phoneValidator(String number) {
    if (number.length < 9 || number.length > 10) {
      return "phone number must contain either 9 or 10 digits";
    }
  }

  signIn() async {
    if (loginKey.currentState!.validate()) {
      UserCredential? userCredential = await AuthHelper.authHelper
          .signIn(emailController.text, passwordController.text);
      AppUser appUser = AppUser(
          id: userCredential!.user!.uid, // unique id from firebase auth
          email: emailController.text,
          userName: userNameController.text,
          phone: phoneController.text,
          city: cityController.text);
      FirestoreHelper.firestoreHelper.getUserFromFirestore(appUser.id!);
      if (userCredential != null) {
        AppRouter.NavigateWithReplacemtnToWidget(CategoriesScreen());
        // emailController.clear();
        // passwordController.clear();
      }
    }
  }

  signUp() async {
    if (signUpKey.currentState!.validate()) {
      UserCredential? userCredential = await AuthHelper.authHelper
          .signUp(emailController.text, passwordController.text);

      AppUser appUser = AppUser(
          id: userCredential!.user!.uid, // unique id from firebase auth
          email: emailController.text,
          userName: userNameController.text,
          phone: phoneController.text,
          city: cityController.text);

      FirestoreHelper.firestoreHelper.addUserToFirestore(appUser);

      if (userCredential != null) {
        AppRouter.NavigateWithReplacemtnToWidget(CategoriesScreen());
        // emailController.clear();
        // passwordController.clear();
        // userNameController.clear();
        // phoneController.clear();
        // cityController.clear();
      }
    }
  }

  checkUser() {
    AuthHelper.authHelper.checkUser();
  }

  signOut() {
    AuthHelper.authHelper.signOut();
  }

  forgetPassword() {
    AuthHelper.authHelper.forgetPassword("h380910@gmail.com");
  }

  verifyEmail() {
    AuthHelper.authHelper.verifyEmail();
  }
}
