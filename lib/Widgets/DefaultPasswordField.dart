import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultPasswordField extends StatelessWidget {
  final IconData icon;
  final TextEditingController controller;
  final bool secure;
  final Function change;
  final String error;
  DefaultPasswordField(
    this.icon,
    this.controller,
    this.secure,
    this.change,
    this.error,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return error;
          }
          return null;
        },
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.visiblePassword,
        obscureText: secure,
        decoration: InputDecoration(
          hintText: "Enter Your Password",
          labelText: "Password",
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "AkayaKanadaka",
            color: Colors.white,
          ),
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "AkayaKanadaka",
              color: Colors.grey),
          prefixIcon: Icon(Icons.lock, color: Colors.white),
          fillColor: Colors.grey.withOpacity(0.1),
          filled: true,
          suffixIcon: IconButton(
            onPressed: change,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
