
import 'package:flutter/material.dart';

class PriceTextfield extends StatelessWidget {
  const PriceTextfield({
    Key? key,
    required this.hintText,
    this.maxLines = 1,
    this.keyboardType = TextInputType.name,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final TextInputType keyboardType;

  final int maxLines;
  final TextEditingController controller;
  // final String doc;

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
        onChanged: (value) {
       
        },
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(10),
          focusColor: Colors.amber,
          border: const OutlineInputBorder(),
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
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
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
