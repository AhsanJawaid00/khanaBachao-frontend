import 'package:flutter/material.dart';
import 'package:tes/utils/app_color.dart';
import 'package:tes/utils/app_fonts.dart';

class VariableText extends StatelessWidget {
  final String text;
  final Color fontColor;
  final TextAlign textAlign;
  final FontWeight weight;
  final bool underlined,lineThrough;
  final String fontfamily;
  final double fontSize,lineSpacing,letterSpacing;
  final int maxLines;
  final TextOverflow overflow;
  const VariableText({this.text="A",
    this.fontColor=AppColor.themeColorBlack,
    this.fontSize=15,
    this.textAlign=TextAlign.center,
    this.weight=FontWeight.normal,
    this.underlined=false,
    this.lineSpacing=1,
    this.letterSpacing=0,
    this.maxLines=1,
    this.fontfamily=AppFonts.MONTSERRAT_REGULAR,
    this.overflow=TextOverflow.ellipsis,
    this.lineThrough=false,
  });
  @override
  Widget build(BuildContext context) {
    return Text(text,
      maxLines: maxLines,overflow: maxLines!=null?TextOverflow.ellipsis:overflow,
      textAlign:textAlign,style:TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: fontColor,fontWeight: weight,
        height: lineSpacing,
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        decorationThickness: 4.0,
        decoration: underlined?TextDecoration.underline:(lineThrough?TextDecoration.lineThrough:
        TextDecoration.none),),);
  }

}