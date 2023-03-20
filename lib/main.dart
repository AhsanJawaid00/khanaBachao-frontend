import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes/models/bottomNavBar.dart';
import 'package:tes/provider/needy_provider.dart';
import 'package:tes/provider/provider.dart';
import 'package:tes/screens/confirm_purchase.dart';
import 'package:tes/screens/get_started_screen.dart';
import 'package:tes/screens/main_screen.dart';
import 'package:tes/screens/sign_up_screen.dart';
import 'package:tes/utils/app_color.dart';

import 'provider/customSlider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<NeedyProvider>(create: (context)=>NeedyProvider()),
        ChangeNotifierProvider<ProvidersProvider>(create: (context)=>ProvidersProvider()),
        ChangeNotifierProvider(create: (_) => CustomSlider()),

        ChangeNotifierProvider(create: (_) => MyBottomNavBarModal()),
      ],
      child: MaterialApp(
        title: 'Khana Bachao',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColor.primaryColor,
        ),
        home: GetStartedScreen(),
        //home: ConfirmPurchaseScreen(),
      ),
    );
  }
}

