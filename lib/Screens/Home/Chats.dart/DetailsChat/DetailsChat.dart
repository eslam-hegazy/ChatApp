import 'package:chatapp/Cubit/HomeCubit/HomeCubit.dart';
import 'package:chatapp/Cubit/HomeCubit/HomeState.dart';
import 'package:chatapp/Model/AuthModel.dart';
import 'package:chatapp/Model/MessageModel.dart';
import 'package:chatapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsChat extends StatelessWidget {
  final AuthModel model;

  DetailsChat(this.model);
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(
        builder: (BuildContext context) {
          HomeCubit.get(context).getMessage(reciveId: model.uid);
          return BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, satte) {
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(model.image),
                      ),
                      SizedBox(width: 10),
                      Text(model.name)
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            var message = HomeCubit.get(context).message[index];
                            if (token == message.sendId)
                              return SentMessage(message);

                            return ReciveMessage(message);
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 1),
                          itemCount: HomeCubit.get(context).message.length,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                fillColor: Colors.white.withOpacity(0.5),
                                filled: true,
                                hintText: "Enter Your Message ........",
                                hintStyle: TextStyle(
                                  fontFamily: "AkayaKanadaka",
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              onPressed: () {
                                HomeCubit.get(context).SendMessage(
                                  reciveId: model.uid,
                                  dataTime: DateTime.now().toString(),
                                  text: messageController.text,
                                );
                                messageController.text = "";
                              },
                              icon: Icon(Icons.send),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ReciveMessage extends StatelessWidget {
  final MessageModel model;

  ReciveMessage(this.model);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            model.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "AkayaKanadaka",
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class SentMessage extends StatelessWidget {
  final MessageModel model;

  SentMessage(this.model);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            model.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "AkayaKanadaka",
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
