

import 'package:flutter/material.dart';
import 'package:tes/custom_widgets/variable_text.dart';
import 'package:tes/screens/receipt_screen.dart';
import 'package:tes/utils/app_color.dart';
import 'package:tes/utils/app_fonts.dart';
import 'package:tes/utils/app_strings.dart';
class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var media=MediaQuery.of(context).size;
    double height=media.height;
    double width=media.width;
    return    Padding(
      padding:  EdgeInsets.only(right: width*0.33),
      child: Container(
        height: height*0.13,
        width: width*0.9,

        decoration: BoxDecoration(
          // color: Colors.red,
            image: DecorationImage(
                image: AssetImage('assets/images/khana bachao logo pg.png',),
                fit: BoxFit.cover
            )
        ),
        //      child: Image.asset('assets/images/khana bachao logo pg.png',fit: BoxFit.fill,),
      ),
    );
  }
}
