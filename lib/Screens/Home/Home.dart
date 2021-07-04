import 'package:chatapp/Cubit/HomeCubit/HomeCubit.dart';
import 'package:chatapp/Cubit/HomeCubit/HomeState.dart';

import 'package:chatapp/Screens/Login/Login.dart';
import 'package:chatapp/helper/CacheHelper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(
        builder: (context) {
          HomeCubit.get(context).getUserDate();
          HomeCubit.get(context).getUsers();
          return BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = HomeCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    cubit.title[cubit.index],
                    style: TextStyle(
                        fontFamily: "AkayaKanadaka",
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {
                        Cachehelper.removeDate(key: 'uid').then((value) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return Login();
                          }));
                        });
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: CurvedNavigationBar(
                  items: [
                    Icon(
                      Icons.chat,
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ],
                  index: HomeCubit.get(context).index,
                  buttonBackgroundColor: Color(0xFF18191a),
                  backgroundColor: Colors.grey,
                  animationCurve: Curves.easeInOut,
                  color: Color(0xFF18191a).withOpacity(0.9),
                  animationDuration: Duration(milliseconds: 600),
                  onTap: (index) {
                    HomeCubit.get(context).ChangeIndex(index);
                  },
                ),
                body: HomeCubit.get(context)
                    .screens[HomeCubit.get(context).index],
              );
            },
          );
        },
      ),
    );
  }
}
