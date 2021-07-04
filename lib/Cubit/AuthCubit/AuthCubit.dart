import 'package:bloc/bloc.dart';
import 'package:chatapp/Cubit/AuthCubit/AuthState.dart';
import 'package:chatapp/Model/AuthModel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());
  static AuthCubit get(context) => BlocProvider.of(context);
  bool see = true;
  IconData icon = Icons.visibility_off;
  void change() {
    icon = see == true ? Icons.visibility : Icons.visibility_off;
    see = !see;

    emit(VisiabilityState());
  }

  AuthModel authModel;
  void CreateUser(
      {@required String name, @required String email, @required String uid}) {
    authModel = AuthModel(
      name: name,
      email: email,
      uid: uid,
      cover:
          "https://image.freepik.com/free-vector/doodle-blank-speech-bubbles-hand-drawn-cartoon-thinking-shapes-set_1284-52007.jpg",
      image:
          "https://image.freepik.com/free-vector/doodle-blank-speech-bubbles-hand-drawn-cartoon-thinking-shapes-set_1284-52007.jpg",
      bio: "bio.............",
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(authModel.toJson())
        .then((value) {
      emit(SuccessfulRegisterState(uid));
    }).catchError((error) {
      print(error.toString());
    });
  }

  void register(
      {@required String name,
      @required String email,
      @required String password}) async {
    emit(LoadingRegisterState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CreateUser(name: name, email: email, uid: value.user.uid);
    }).catchError((error) {
      emit(ErrorRegisterState(error.message.toString()));
      print(error.message.toString());
    });
  }

  void login({@required String email, @required String password}) {
    emit(LoadingLoginState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SuccessfulLoginState(value.user.uid));
    }).catchError((error) {
      print(error.message.toString());
      emit(ErrorLoginState(error.message.toString()));
    });
  }
}
