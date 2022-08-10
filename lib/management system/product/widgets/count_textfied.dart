import 'package:flutter/material.dart';

class CountTextfield extends StatelessWidget {
  const CountTextfield({
    Key? key,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.name,
    required this.controller,
    required this.doc,
  }) : super(key: key);

  final String hintText;
  final TextInputType keyboardType;

  final int maxLines;
  final TextEditingController controller;
  final String doc;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return '*required';
          }
          return null;
        },
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(10),
          focusColor: Colors.amber,
          border: OutlineInputBorder(),
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
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}