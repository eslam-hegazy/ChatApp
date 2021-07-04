import 'package:chatapp/Cubit/HomeCubit/HomeCubit.dart';
import 'package:chatapp/Cubit/HomeCubit/HomeState.dart';
import 'package:chatapp/Screens/Home/Profile.dart/ButtonEdit.dart';
import 'package:chatapp/Screens/Home/Profile.dart/Editprofile/EditProfile.dart';
import 'package:chatapp/Screens/Home/Profile.dart/ItemProfile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Head.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserDate(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context).authModel;
          return state is LoadingHomeState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Head(
                            cubit.cover == null
                                ? "https://image.flaticon.com/icons/png/512/1004/1004779.png"
                                : cubit.cover,
                            cubit.image == null
                                ? "https://image.flaticon.com/icons/png/512/1004/1004779.png"
                                : cubit.image,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              cubit.name,
                              style: TextStyle(
                                fontFamily: "AkayaKanadaka",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            cubit.bio,
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "AkayaKanadaka",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return EditProfile(cubit);
                              }));
                            },
                            child: ButtonEdit(),
                          ),
                          ItemProfile("User name", cubit.name),
                          ItemProfile("Email Address", cubit.email),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
