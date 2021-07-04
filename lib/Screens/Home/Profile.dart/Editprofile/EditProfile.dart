import 'package:chatapp/Cubit/HomeCubit/HomeCubit.dart';
import 'package:chatapp/Cubit/HomeCubit/HomeState.dart';
import 'package:chatapp/Model/AuthModel.dart';
import 'package:chatapp/Screens/Home/Home.dart';
import 'package:chatapp/Screens/Home/Profile.dart/Profile.dart';

import 'package:chatapp/Widgets/DefaultTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  final AuthModel authModel;

  EditProfile(this.authModel);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUserDate(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is SuccessfulUpdate) {
            HomeCubit.get(context).getUserDate();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          nameController.text = authModel.name;
          bioController.text = authModel.bio;
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      HomeCubit.get(context).getUserDate();
                      cubit.UpdateUser(
                          name: nameController.text, bio: bioController.text);
                    },
                    child: Text(
                      "UpDate",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: "AkayaKanadaka",
                      ),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    if (state is LoadingUpdate) LinearProgressIndicator(),
                    SizedBox(height: 6),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.32,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: cubit.coverUser == null
                                        ? NetworkImage(authModel.cover)
                                        : FileImage(cubit.coverUser),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.getCoverUser();
                                    },
                                    icon: Icon(
                                      Icons.camera,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                    backgroundImage: cubit.imagUser == null
                                        ? NetworkImage(authModel.image)
                                        : FileImage(cubit.imagUser),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.grey.withOpacity(0.5),
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.getImageUser();
                                        },
                                        icon: Icon(
                                          Icons.camera,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    DefaultTextFormField(Icon(Icons.person), "Enter Your Name",
                        "user Name", TextInputType.text, nameController, ""),
                    DefaultTextFormField(Icon(Icons.person), "nter Your Bio",
                        "Bio", TextInputType.text, bioController, ""),
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
