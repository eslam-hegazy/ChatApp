import 'package:chatapp/Cubit/AuthCubit/AuthState.dart';
import 'package:chatapp/Cubit/HomeCubit/HomeCubit.dart';
import 'package:chatapp/Cubit/HomeCubit/HomeState.dart';
import 'package:chatapp/Screens/Home/Chats.dart/DetailsChat/DetailsChat.dart';
import 'package:chatapp/Screens/Home/Chats.dart/ItemChat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return state is LoadinGetUsers
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.users.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return DetailsChat(cubit.users[index]);
                          }));
                        },
                        child: ItemChat(
                            cubit.users[index].image, cubit.users[index].name),
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
