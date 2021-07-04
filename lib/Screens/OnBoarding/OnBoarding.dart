import 'package:chatapp/Cubit/OnBoardinCubit/OnBoardingCubit.dart';
import 'package:chatapp/Cubit/OnBoardinCubit/OnBoardingState.dart';
import 'package:chatapp/Screens/Login/Login.dart';
import 'package:chatapp/Widgets/DefaultButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'head.dart';

class OnBoarding extends StatelessWidget {
  var pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cubit = OnBoardingCubit.get(context);
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) {
                      return Login();
                    }));
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        fontFamily: "AkayaKanadaka",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: cubit.board.length,
                    onPageChanged: (index) {
                      if (index == cubit.board.length - 1) {
                        cubit.change(true);
                      } else {
                        cubit.change(false);
                      }
                    },
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return head(context, cubit.board[index]);
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SmoothPageIndicator(
                  controller: pageController, // PageController
                  count: 3,
                  effect: ExpandingDotsEffect(
                    spacing: 5,
                    dotHeight: 11,
                    dotWidth: 11,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                  ), // your preferred effect
                  onDotClicked: (index) {},
                ),
                SizedBox(height: size.height * 0.02),
                InkWell(
                  onTap: () {
                    if (cubit.end == true) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return Login();
                      }));
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeInOutQuint);
                    }
                  },
                  child: DefaultButton("GetStart"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
