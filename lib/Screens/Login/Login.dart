import 'package:chatapp/Cubit/AuthCubit/AuthCubit.dart';
import 'package:chatapp/Cubit/AuthCubit/AuthState.dart';
import 'package:chatapp/Screens/Home/Home.dart';
import 'package:chatapp/Screens/Register/Register.dart';
import 'package:chatapp/Widgets/DefaultButton.dart';
import 'package:chatapp/Widgets/DefaultPasswordField.dart';
import 'package:chatapp/Widgets/DefaultTextFormField.dart';
import 'package:chatapp/helper/CacheHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SuccessfulLoginState) {
            Cachehelper.setDate(key: 'uid', value: state.token).then((value) {
              var token = Cachehelper.getDate(key: 'uid');
              print(token);

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return Home();
              }));
            }).catchError((error) {
              print(error);
            });
          } else if (state is ErrorLoginState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.1),
                      Container(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 66,
                              backgroundColor: Colors.white,
                            ),
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: Color(0xFF18191a),
                              child:
                                  Lottie.asset("images/29683-chit-chat.json"),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Login !",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "AkayaKanadaka",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login Now To Chat Our Hot People !",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DefaultTextFormField(
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        "Email Address",
                        "Email",
                        TextInputType.emailAddress,
                        emailController,
                        "Please Enter Your Email",
                      ),
                      DefaultPasswordField(
                        cubit.icon,
                        passwordController,
                        cubit.see,
                        () {
                          cubit.change();
                        },
                        "Please Enter Your Password",
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "AkayaKanadaka",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState.validate()) {
                            cubit.login(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        child: state is LoadingLoginState
                            ? Lottie.asset(
                                "images/9825-loading-screen-loader-spinning-circle.json",
                                height: 60,
                              )
                            : DefaultButton("Login"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have An Account ? ",
                            style: TextStyle(
                              fontFamily: "AkayaKanadaka",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                return Register();
                              }));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                fontFamily: "Cairo",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
