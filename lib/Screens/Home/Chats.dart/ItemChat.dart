import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemChat extends StatelessWidget {
  final String image;
  final String name;

  ItemChat(this.image, this.name);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.all(13),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(image),
              ),
              SizedBox(width: 15),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "AkayaKanadaka",
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
