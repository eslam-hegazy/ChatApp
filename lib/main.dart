import 'package:bloc/bloc.dart';
import 'package:chatapp/Cubit/AuthCubit/AuthCubit.dart';
import 'package:chatapp/Cubit/HomeCubit/HomeCubit.dart';
import 'package:chatapp/Cubit/OnBoardinCubit/OnBoardingCubit.dart';
import 'package:chatapp/Screens/Home/Home.dart';
import 'package:chatapp/Screens/Login/Login.dart';

import 'package:chatapp/helper/CacheHelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helper/MyBlocObserver.dart';

var token;
void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen((event) {
    print("Successful onMessage");
  }).onError((error) {
    print("Error");
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("Successful onMessageOpenedApp");
  }).onError((error) {
    print("Error");
  });
  await Cachehelper.init();
  Widget widget;
  token = Cachehelper.getDate(key: 'uid');
  if (token == null) {
    widget = Login();
  } else {
    widget = Home();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Social App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFF18191a),
          elevation: 0,
        ),
        scaffoldBackgroundColor: Color(0xFF18191a),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<OnBoardingCubit>(
            create: (BuildContext context) => OnBoardingCubit(),
          ),
          BlocProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit(),
          ),
        ],
        child: widget,
      ),
    );
  }
}
