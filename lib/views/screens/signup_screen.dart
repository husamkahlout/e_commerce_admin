import 'package:country_code_picker/country_code_picker.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/firestore_provider.dart';
import 'package:e_commerce/router/router.dart';
import 'package:e_commerce/views/widgets/already_have_an_account_acheck.dart';
import 'package:e_commerce/views/widgets/background.dart';
import 'package:e_commerce/views/screens/login_screen.dart';
import 'package:e_commerce/views/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: MobileSignupScreen(),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, x) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              // Text(
              //   "Sign Up".toUpperCase(),
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SvgPicture.asset("assets/icons/signup.svg"),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: defaultPadding),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 8,
                child: Form(
                  key: authProvider.signUpKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      CustomTextField(
                          customHintText: "Your Name",
                          textFieldValidator: authProvider.nullValidation,
                          textFieldController: authProvider.userNameController,
                          prefixIcon: Icon(Icons.person),
                          isSecure: false,
                          textInputType: TextInputType.text),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: CustomTextField(
                          customHintText: "Your Email",
                          textFieldValidator: authProvider.emailValidation,
                          textFieldController: authProvider.emailController,
                          prefixIcon: Icon(Icons.email_rounded),
                          textInputType: TextInputType.emailAddress,
                          isSecure: false,
                        ),
                      ),
                      TextFormField(
                          controller: authProvider.phoneController,
                          validator: (value) =>
                              authProvider.phoneValidator(value!),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                              hintText: "Your phone",
                              prefixIcon: const Padding(
                                  padding: EdgeInsets.all(defaultPadding),
                                  child: Icon(Icons.phone)),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(0),
                                child: CountryCodePicker(
                                  onChanged: (value) {
                                    authProvider.countryCode = value.dialCode;
                                  },
                                  initialSelection: "PS",
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                              ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: CustomTextField(
                            customHintText: "Your city",
                            textFieldValidator: authProvider.nullValidation,
                            textFieldController: authProvider.cityController,
                            prefixIcon: Icon(Icons.location_on_rounded),
                            isSecure: false,
                            textInputType: TextInputType.text),
                      ),
                      CustomTextField(
                        customHintText: "Your password",
                        textFieldValidator: authProvider.passwordValidation,
                        textFieldController: authProvider.passwordController,
                        prefixIcon: Icon(Icons.lock),
                        textInputType: TextInputType.text,
                        isSecure: true,
                      ),
                      const SizedBox(height: defaultPadding * 1.5),
                      ElevatedButton(
                        onPressed: () {
                          authProvider.signUp();
                          // Provider.of<FirestoreProvider>(context, listen: false).addNewUser();
                        },
                        child: Text("Sign Up".toUpperCase()),
                      ),
                      const SizedBox(height: defaultPadding),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          AppRouter.NavigateWithReplacemtnToWidget(
                              LoginScreen());
                        },
                      ),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      );
    });
  }
}
