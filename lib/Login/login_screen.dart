import 'package:admin_app/Login/widgets/email_textfield.dart';
import 'package:admin_app/Login/widgets/password_textfield.dart';
import 'package:admin_app/Services/Auth_services.dart';
import 'package:admin_app/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmailTextfield(
                controller: emailController,
                icon: Icons.email,
              ),
              const SizedBox(
                height: 20,
              ),
              PasswordTextfield(
                controller: passwordController,
                icon: Icons.lock,
              ),
              const SizedBox(
                height: 40,
              ),
              buildSignInButton(context)
            ],
          ),
        ),
      ),
    );
  }

// ================================================================================
// This method is used to show the sign in button.

  ElevatedButton buildSignInButton(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(HexColor('#EF0030').withOpacity(0.8)),
      ),
      onPressed: () async {
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;

        if (emailController.text == "" || passwordController.text == "") {
          Get.snackbar("All Feilds Are Required", "");
        } else {
          User? result = await AuthService()
              .login(emailController.text, passwordController.text);
          if (result != null) {
            print(result.email);
            Get.offUntil(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false);
          }
        }

        // try {
        //   await firebaseAuth
        //       .signInWithEmailAndPassword(
        //           email: emailController.text,
        //           password: passwordController.text)
        //       .then((value) {
        //     // Get.off(HomeScreen());
        //     Get.offUntil(
        //         MaterialPageRoute(
        //           builder: (context) => HomeScreen(),
        //         ),
        //         (route) => false);
        //   });
        // } on FirebaseAuthException catch (e) {
        //   Get.snackbar("Message", e.message!);
        // }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: mediaQuery.height * 0.017,
          horizontal: mediaQuery.width * 0.32,
        ),
        child: Text(
          'SIGN IN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
