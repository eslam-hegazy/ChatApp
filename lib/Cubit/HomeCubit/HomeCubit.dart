import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chatapp/Cubit/HomeCubit/HomeState.dart';
import 'package:chatapp/Model/AuthModel.dart';
import 'package:chatapp/Model/MessageModel.dart';
import 'package:chatapp/Screens/Home/Chats.dart/Chats.dart';
import 'package:chatapp/Screens/Home/Profile.dart/Profile.dart';
import 'package:chatapp/helper/CacheHelper.dart';
import 'package:chatapp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);
  List screens = [
    Chats(),
    Profile(),
  ];
  List title = [
    "Chats",
    "Profile",
  ];
  int index = 0;
  void ChangeIndex(int value) {
    index = value;
    emit(ChangeBar());
  }

  AuthModel authModel;
  var uid = Cachehelper.getDate(key: 'uid');
  void getUserDate() async {
    emit(LoadingHomeState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(token)
        .snapshots()
        .listen((event) {
      emit(SuccessFullHomeState());
      authModel = AuthModel.fromJson(event.data());
    });
  }

  File coverUser;
  final picker1 = ImagePicker();

  Future getCoverUser() async {
    final pickedFile = await picker1.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverUser = File(pickedFile.path);
      emit(UploadCoverState());
      uploadCoverUser();
      print(pickedFile.path);
    } else {
      emit(ErrorCoverState());
      print('No image selected.');
    }
  }

  File imagUser;
  final picker2 = ImagePicker();

  Future getImageUser() async {
    final pickedFile = await picker2.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagUser = File(pickedFile.path);
      emit(UploadImageState());
      uploadImageUser();
      print(pickedFile.path);
    } else {
      emit(ErrorImageState());
      print('No image selected.');
    }
  }

  String CoverUrl = "";
  void uploadCoverUser() async {
    emit(LoadingCoverImage());

    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverUser.path).pathSegments.last}')
        .putFile(coverUser)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CoverUrl = value;
        print(CoverUrl);
        emit(UploadCoverImage());
      }).catchError((error) {
        print(value);
        emit(ErrorCoverImage());
      });
    }).catchError((error) {});
  }

  String ImageUrl = "";
  void uploadImageUser() async {
    emit(LoadingImage());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imagUser.path).pathSegments.last}')
        .putFile(imagUser)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        ImageUrl = value;
        print(CoverUrl);
        emit(UploadImage());
      }).catchError((error) {
        print(value);
        emit(ErrorImage());
      });
    }).catchError((error) {});
  }

  void UpdateUser({@required String name, @required String bio}) {
    emit(LoadingUpdate());
    AuthModel update = AuthModel(
      name: name,
      email: authModel.email,
      uid: token,
      cover: CoverUrl == "" ? authModel.cover : CoverUrl,
      image: ImageUrl == "" ? authModel.image : ImageUrl,
      bio: bio,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(token)
        .update(update.toJson())
        .then((value) {
      getUserDate();
      emit(SuccessfulUpdate());
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<AuthModel> users = [];
  void getUsers() {
    emit(LoadinGetUsers());
    FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      emit(SuccessfullGetUsers());
      users = [];
      event.docs.forEach((element) {
        if (element.data()['uid'] != token) {
          users.add(AuthModel.fromJson(element.data()));
        }
      });
    });
  }

  void SendMessage(
      {@required String reciveId,
      @required String dataTime,
      @required String text}) {
    MessageModel messageModel = MessageModel(
      sendId: token,
      reciveId: reciveId,
      dataTime: dataTime,
      text: text,
    );

    ///set message
    FirebaseFirestore.instance
        .collection("users")
        .doc(token)
        .collection("chat")
        .doc(reciveId)
        .collection("message")
        .add(messageModel.toJson())
        .then((value) {
      emit(SuccessfulSendMessage());
    }).catchError((error) {
      emit(ErrorSendMessage());
    });

    ///recive message
    FirebaseFirestore.instance
        .collection("users")
        .doc(reciveId)
        .collection("chat")
        .doc(token)
        .collection("message")
        .add(messageModel.toJson())
        .then((value) {
      emit(SuccessfulReciveMessage());
    }).catchError((error) {
      emit(ErrorReciveMessage());
    });
  }

  List<MessageModel> message = [];
  void getMessage({@required String reciveId}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(token)
        .collection("chat")
        .doc(reciveId)
        .collection("message")
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(MessageModel.fromJson(element.data()));
      });
      emit(GetmessageSuccessful());
    });
  }
}
