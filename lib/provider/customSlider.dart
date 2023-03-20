import 'package:flutter/material.dart';
class CustomSlider extends ChangeNotifier{
  double? value;
  CustomSlider({this.value});

  void changeValue(double val){
    value = val;
    notifyListeners();
  }
}