import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget DefaultButton(text) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    child: Container(
      height: 55,
      alignment: Alignment.center,
      width: double.infinity,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontFamily: "AkayaKanadaka",
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.red,
      ),
    ),
  );
}
