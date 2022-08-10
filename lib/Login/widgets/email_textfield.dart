import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EmailTextfield extends StatelessWidget {
  const EmailTextfield({
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

    return SizedBox(
      child: TextFormField(
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
        decoration: InputDecoration(
          label: Text(
            'email',
            style: TextStyle(
              color: Colors.black,
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
    );
  }
}
