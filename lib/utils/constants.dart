import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(String hintText) {
  return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      hintText: hintText);
}
