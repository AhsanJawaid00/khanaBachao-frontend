

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tes/custom_widgets/dialogs.dart';
import 'package:tes/models/bottomNavBar.dart';
import 'package:tes/provider/provider.dart';
import 'package:tes/screens/ExploreScreen.dart';
import 'package:tes/screens/FoodDetails.dart';
import 'package:tes/screens/HomeScreen.dart';
import 'package:tes/shared_preference.dart';
import 'package:tes/urls/url_constants.dart';
import 'package:tes/utils/app_strings.dart';

import 'role_selection_screen.dart';
class ProviderMainMenu extends StatefulWidget {
  ProviderMainMenu({Key? key}) : super(key: key);
  static List _widgetOptions = [
    HomeScreen(),
    FoodDetails(),
    ExploreScreen(),
    Container(),
  ];

  @override
  State<ProviderMainMenu> createState() => _ProviderMainMenuState();
}

class _ProviderMainMenuState extends State<ProviderMainMenu> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.delayed(const Duration(milliseconds: 10), () {
          exit(0);
        });

      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<MyBottomNavBarModal>(
            builder: (context,navBar,child){
              if(navBar.index==null){
                navBar.index=1;
              }
              return ProviderMainMenu._widgetOptions.elementAt(navBar.index ?? 1);
            }
          ),
        ),
        bottomNavigationBar: Consumer<MyBottomNavBarModal>(
          builder: (context,navBar,child){
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              unselectedItemColor: Colors.black.withOpacity(0.7),
              selectedItemColor: Colors.black.withOpacity(0.7),
              onTap: (val){
                navBar.changeValue(val);
               if(navBar.index==3){
                 logOut(context);
               }
              },
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  tooltip: 'Home'.toUpperCase(),
                  icon: Icon(Icons.home,color: navBar.index==0?Color(0xffa606b1):Colors.black.withOpacity(0.7),),
                  label:'HOME'
                ),
                BottomNavigationBarItem(
                    tooltip: 'charities'.toUpperCase(),
                    icon: Icon(Icons.favorite,color: navBar.index==1?Color(0xffa606b1):Colors.black.withOpacity(0.7),),
                    label: 'charities'.toUpperCase()
                ),
                BottomNavigationBarItem(
                    tooltip: 'Explore'.toUpperCase(),
                    icon: Icon(Icons.search,color: navBar.index==2?Color(0xffa606b1):Colors.black.withOpacity(0.7),),
                    label: 'Explore'.toUpperCase() ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person,color: navBar.index==3?Color(0xffa606b1):Colors.black.withOpacity(0.7),),
                  tooltip: 'Logout'.toUpperCase(),
                    label: 'Logout'.toUpperCase()
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> logOut(BuildContext context) async {
    AppDialogs.progressAlertDialog(context: context);
    Response response;
    Dio dio = new Dio();


String? token= SharedPreference().getBearerTokenForNeedy();

    try {
      // print("env variable ${dotenv.env}");

      response=await  dio.post("${Constantsurl.CONSTANT_URL}/users/logout", data: null,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),);

      if(response.statusCode==200){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Log out SuccessFully", toastLength: Toast.LENGTH_SHORT);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => SelectType()),
                (Route<dynamic> route) => false);
        SharedPreference().clear();
        Provider.of<ProvidersProvider>(context,listen: false).setCurrentProviderFromSharedPreference(user: null);

        //setLoading(false);
      }
      else{
        Navigator.pop(context);
        print('Error: $response');

        Fluttertoast.showToast(msg: AppStrings.SOME_THING, toastLength: Toast.LENGTH_SHORT);

        Navigator.pop(context);
      }
      // return response;
    } catch (e) {

      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_SHORT);
      Navigator.pop(context);
      // setLoading(false);
      print('Error: $e');
    }
  }
}
