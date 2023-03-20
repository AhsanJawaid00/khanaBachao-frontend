import 'package:flutter/material.dart';
class MyBottomNavBarModal extends ChangeNotifier{
  int? index;
  MyBottomNavBarModal({ this.index});

  void changeValue(int val){
    index = val;
    notifyListeners();
  }

}