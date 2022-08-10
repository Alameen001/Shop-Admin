import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoryTextField extends StatelessWidget {
  CategoryTextField({
    Key? key,
    required this.controller,
    required this.formKey,
  }) : super(key: key);

  final TextEditingController controller;
  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return SizedBox(
      // height: 50,
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: TextInputType.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return '*required';
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: 'eg. Shirts',

            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),

            // hintStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.all(10),
            // focusColor: Colors.amber,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black45,
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
