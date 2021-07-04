import 'package:bloc/bloc.dart';
import 'package:chatapp/Cubit/OnBoardinCubit/OnBoardingState.dart';
import 'package:chatapp/Model/OnBoardingModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(InitialOnBoardingState());
  static OnBoardingCubit get(context) => BlocProvider.of(context);
  List<OnBoardingModel> board = [
    OnBoardingModel("images/53468-chat-goyang.json", "Your Space in Your Dream",
        "A lag-free video chat connnection between Your Users is easy and Much everyWhere On any Device."),
    OnBoardingModel(
        "images/23414-chat-bubbles-inside-phone.json",
        "Chat AnyTime, anyWhere",
        "Passing of any information on any screen, any device instantly is made simple at its sublime."),
    OnBoardingModel(
        "images/63029-chatting-couple-animation.json",
        "perfect Chat Solution",
        "Your Space in your Dream Your Space in your Dream Your Space in your Dream are space in your dream."),
  ];
  bool end = false;
  void change(bool value) {
    end = value;
  }
}
