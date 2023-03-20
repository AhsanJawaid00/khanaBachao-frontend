
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:tes/models/needy_data_model.dart';

class NeedyProvider with ChangeNotifier {
  NeedyDataModel? _currentNeedy;


  ////////////////getters///////////
  NeedyDataModel? get getCurrentNeedy=> _currentNeedy;

////////////// setters //////////////
  void setCurrentNeedy({dynamic user}){
    if(user!=null){
      _currentNeedy=NeedyDataModel.fromJson(user);
    }
    else{
      _currentNeedy=null;
    }
    notifyListeners();
  }

  ////////////// from shared preference //////////////
  void setCurrentNeedyFromSharedPreference({String? user}){
    if(user!=null){
      var jsonResponse = jsonDecode(user);
      _currentNeedy=NeedyDataModel.fromJson(jsonResponse);
    }
    else{
      _currentNeedy=null;
    }
    notifyListeners();
  }
}