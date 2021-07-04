import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.09,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "AkayaKanadaka",
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
