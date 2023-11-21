import 'package:flutter/material.dart';

class TextFieldLoginSubscribe extends StatelessWidget {

  final controller;
  final String hintText;
  final bool obscureText;
  final bool numberKeyBoard;

  const TextFieldLoginSubscribe({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.numberKeyBoard,
  });

  @override
  Widget build(BuildContext context) {

    TextInputType keyboardType = TextInputType.text;

    if (numberKeyBoard) {
      keyboardType = TextInputType.number;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}