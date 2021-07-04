import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final String labelText;
  final TextInputType type;
  final TextEditingController controller;
  final String error;
  DefaultTextFormField(
    this.icon,
    this.hintText,
    this.labelText,
    this.type,
    this.controller,
    this.error,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "AkayaKanadaka",
        ),
        validator: (value) {
          if (value.isEmpty) {
            return error;
          }
          return null;
        },
        keyboardType: type,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "AkayaKanadaka",
            color: Colors.white,
          ),
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "AkayaKanadaka",
              color: Colors.grey),
          prefixIcon: icon,
          fillColor: Colors.grey.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
