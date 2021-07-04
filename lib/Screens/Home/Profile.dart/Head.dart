import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Head extends StatelessWidget {
  final String cover;
  final String image;

  Head(this.cover, this.image);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(cover),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                  ),
                  CircleAvatar(
                    radius: 53,
                    backgroundImage: NetworkImage(image),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
