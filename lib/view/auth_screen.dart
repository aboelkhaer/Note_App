import 'package:bianat_app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  // TextFormField(
                  //   keyboardType: TextInputType.text,
                  //   textInputAction: TextInputAction.next,
                  //   decoration: InputDecoration(
                  //     labelText: 'Email',
                  //   ),
                  //   validator: (value) {
                  //     return controller.validateEmail(value!);
                  //   },
                  // ),
                  // TextFormField(
                  //   keyboardType: TextInputType.text,
                  //   obscureText: true,
                  //   textInputAction: TextInputAction.done,
                  //   decoration: InputDecoration(
                  //     labelText: 'Password',
                  //   ),
                  //   validator: (value) {
                  //     return controller.validatePassword(value!);
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  SignInButton(
                      buttonType: ButtonType.google,
                      onPressed: () => controller.signInWithGoogle()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
