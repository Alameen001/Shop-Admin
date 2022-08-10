import 'package:admin_app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordTextfield extends StatelessWidget {
  const PasswordTextfield({
    Key? key,
    this.height = 50,
    this.keyboardType = TextInputType.name,
    required this.controller,
    required this.icon,
 
  }) : super(key: key);

  final TextInputType keyboardType;
  final double height;
  final TextEditingController controller;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final logincontroller = Get.put(LoginController());

    return SizedBox(
      child: Obx(
        () => TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return '*required';
            }
            return null;
          },
          obscureText: logincontroller.obscureText.value,
          decoration: InputDecoration(
            label: Text(
              'Password',
              style: TextStyle(
                color: Colors.black,
              ),
            ),

            suffixIcon: IconButton(
              onPressed: () {
                logincontroller.obscureText.value =
                    !logincontroller.obscureText.value;
              },
              icon: Icon(
                logincontroller.obscureText.value
                    ? Icons.remove_red_eye
                    : Icons.visibility_off,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            suffixIconColor: Colors.black,
            suffixStyle: TextStyle(
              color: Colors.black,
            ),
            prefixIcon: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    icon,
                    color: Colors.black,
                  ),
                  VerticalDivider(
                    color: HexColor('#583C3C').withOpacity(0.17),
                    thickness: 1,
                    endIndent: 10,
                    indent: 10,
                  )
                ],
              ),
            ),
            // hintStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.all(10),
            // focusColor: Colors.amber,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: HexColor('#583C3C').withOpacity(0.17),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black45,
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
