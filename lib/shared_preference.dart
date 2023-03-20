
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/utils/app_strings.dart';


class SharedPreference {
  static SharedPreference? _sharedPreferenceHelper;
  static SharedPreferences? _sharedPreferences;

  SharedPreference._createInstance();

  factory SharedPreference() {
    // factory with constructor, return some value
    if (_sharedPreferenceHelper == null) {
      _sharedPreferenceHelper = SharedPreference
          ._createInstance(); // This is executed only once, singleton object
    }
    return _sharedPreferenceHelper!;
  }

  Future<SharedPreferences> get sharedPreference async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _sharedPreferences!;
  }

  ////////////////////// Clear Preference ///////////////////////////
  void clear() {
    _sharedPreferences?.clear();
  }

  ////////////////////// Bearer Token for User///////////////////////////

  void setBearerTokenForNeedy({String? token}) {
    _sharedPreferences?.setString(AppStrings.BEARER_TOKEN_KEY_NEDDY, token ?? "");
  }



  String? getBearerTokenForNeedy() {
    return _sharedPreferences?.getString(AppStrings.BEARER_TOKEN_KEY_NEDDY);
  }

  ////////////////////// User ///////////////////////////
  void setNeedy({String? user}) {
    _sharedPreferences!.setString(AppStrings.CURRENT_NEEDY_DATA_KEY, user ?? "");
  }

  String? getNeedy() {
    return _sharedPreferences!.getString(AppStrings.CURRENT_NEEDY_DATA_KEY);
  }

  ////////////////////// Bearer Token for Seller///////////////////////////

  void setBearerTokenForProvider({String? token}) {
    _sharedPreferences!.setString(AppStrings.BEARER_TOKEN_KEY_PROVIDER, token??"");
  }

  String? getBearerTokenForProvider() {
    log("token is"+ _sharedPreferences!.getString(AppStrings.BEARER_TOKEN_KEY_PROVIDER).toString());
    return _sharedPreferences?.getString(AppStrings.BEARER_TOKEN_KEY_PROVIDER);
  }

  ////////////////////// Seller ///////////////////////////
  void setProvider({String? seller}) {
    _sharedPreferences?.setString(AppStrings.CURRENT_PROVIDER_DATA_KEY, seller ?? "");
  }

  String? getProvider() {
    return _sharedPreferences?.getString(AppStrings.CURRENT_PROVIDER_DATA_KEY);
  }
  ////////////////////// Notification Message Id ///////////////////////////
  void setNotificationMessageId({String? messageId}) {
    _sharedPreferences!.setString(AppStrings.NOTIFICATION_MESSAGE_ID_KEY, messageId ?? "");
  }

  String? getNotificationMessageId() {
    return _sharedPreferences!.getString(AppStrings.NOTIFICATION_MESSAGE_ID_KEY);
  }



}