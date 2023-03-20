import 'package:flutter/material.dart';
import 'package:tes/utils/app_fonts.dart';

class CustomTextFormFeild extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;

   CustomTextFormFeild({Key? key,this.hintText,this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    double height=media.height;
    double width=media.width;    return    Container(
      margin: EdgeInsets.only(top: height*0.015),
      width: width,
      height: height*0.07,
      child: TextField(
        cursorColor: Colors.black,
        controller: controller,
        decoration:  InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.white24)
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.white24)
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.white24)
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: Colors.grey.shade500),

        ),
      ),
    );
  }
}
