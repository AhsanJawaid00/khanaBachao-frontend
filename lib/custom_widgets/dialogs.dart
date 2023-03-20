import 'package:flutter/material.dart';
import 'package:tes/utils/app_color.dart';

class AppDialogs{
  static void progressAlertDialog({required BuildContext context}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
              child: CircularProgressIndicator(
                color: AppColor.themeColorPurple,
              ),
            ),
          );
        }
    );
  }
}