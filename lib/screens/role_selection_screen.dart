
import 'package:flutter/material.dart';
import 'package:tes/custom_widgets/custom_logo_widget.dart';
import 'package:tes/custom_widgets/variable_text.dart';
import 'package:tes/screens/login_screen.dart';
import 'package:tes/utils/app_fonts.dart';

import '../utils/app_color.dart';
import '../utils/app_strings.dart';

class SelectType extends StatelessWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;

    var media=MediaQuery.of(context).size;
    double height=media.height;
    double width=media.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: height*0.1),
            CustomLogoWidget(),
            SizedBox(height: height*0.1),
            VariableText(
              text: AppStrings.GET_STARTEDD,
              fontfamily: AppFonts.PROMXIA_REGULAR,
              weight: FontWeight.w800,
              fontSize: 25,
              fontColor: Colors.grey,
            ),
            SizedBox(height: height*0.02),
            VariableText(
              text: AppStrings.LOGIN_AS,
              fontfamily: AppFonts.PROMXIA_REGULAR,
              weight: FontWeight.w800,
              fontSize: 25,
              fontColor: AppColor.themeColorBlack,
            ),
            SizedBox(height: size.height*0.05,),


            _customButton(context: context,height: height,width: width,text: AppStrings.PROVIDER,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInScreen(fromNeedy: false,)));

            }),
            SizedBox(height: size.height*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(width: size.width*0.35,color: AppColor.themeColorPurple,height: size.height*0.002,),
                VariableText(
                  text: " OR  ",
                  fontfamily: AppFonts.PROMXIA_REGULAR,
                  weight: FontWeight.w800,
                  fontSize: 25,
                  fontColor: AppColor.themeColorBlack,
                ),
                Container(width: size.width*0.35,color: AppColor.themeColorPurple,height: size.height*0.002,),
              ],
            ),
            SizedBox(height: size.height*0.05,),
            _customButton(context: context,height: height,width: width,text: AppStrings.NEEDY,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInScreen(fromNeedy: true ,)));

                }),
   /*         GestureDetector(
              onTap: (){*//*
                Provider.of<MyBottomNavBarModal>(context,listen: false).index=2;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyBottomNavBar()));*//*
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffa606b1),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                width: size.width*0.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text('Needy',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),)),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _customButton({double? height,double? width,BuildContext? context,String? text,Function()? onTap}){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height!*0.075,
          decoration: BoxDecoration(
              color: AppColor.themeColorPurple,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: VariableText(
              text:text!,
              fontColor: AppColor.themeColorWhite,
              fontfamily: AppFonts.PROMXIA_REGULAR,
              weight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
