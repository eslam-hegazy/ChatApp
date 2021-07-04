import 'package:chatapp/Model/OnBoardingModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget head(context, OnBoardingModel model) {
  var size = MediaQuery.of(context).size;
  return Column(
    children: [
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: Lottie.asset(model.image),
        ),
      ),
      SizedBox(height: size.height * 0.02),
      Text(
        model.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "AkayaKanadaka",
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: size.height * 0.01),
      Text(
        model.description,
        overflow: TextOverflow.fade,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontFamily: "Cairo",
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
