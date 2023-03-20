
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:tes/models/needy_data_model.dart';
import 'package:tes/models/provider_data_model.dart';

class ProvidersProvider with ChangeNotifier {
  ProviderDataModel? _currentProvider;


  ////////////////getters///////////
  ProviderDataModel? get getCurrentProvider=> _currentProvider;

////////////// setters //////////////
  void setCurrentProvider({dynamic user}){
    if(user!=null){
      _currentProvider=ProviderDataModel.fromJson(user);
    }
    else{
      _currentProvider=null;
    }
    notifyListeners();
  }

  ////////////// from shared preference //////////////
  void setCurrentProviderFromSharedPreference({String? user}){
    if(user!=null){
      var jsonResponse = jsonDecode(user);
      _currentProvider=ProviderDataModel.fromJson(jsonResponse);
    }
    else{
      _currentProvider=null;
    }
    notifyListeners();
  }
}