import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tes/custom_widgets/custom_logo_widget.dart';
import 'package:tes/custom_widgets/custom_text_field.dart';
import 'package:tes/custom_widgets/dialogs.dart';
import 'package:tes/custom_widgets/process_loading.dart';
import 'package:tes/custom_widgets/variable_text.dart';
import 'package:tes/screens/login_screen.dart';
import 'package:tes/screens/main_screen.dart';
import 'package:tes/screens/receipt_screen.dart';
import 'package:tes/utils/app_color.dart';
import 'package:tes/utils/app_fonts.dart';
import 'package:tes/utils/app_strings.dart';
class SignUpScreen extends StatefulWidget {
  bool? fromNeedy;
   SignUpScreen({Key? key,this.fromNeedy}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _confirmPasswordController=TextEditingController();
  TextEditingController _organizationNameController=TextEditingController();

  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
  Future<void> createOrganization(String userType) async {

    AppDialogs.progressAlertDialog(context: context);
   //setLoading(true);
    Response response;
    Dio dio = new Dio();
    Map<String,dynamic> body =  {
      "name": _nameController.text,
      "email": _emailController.text,
      "phone":_phoneController.text,
      "location": "location"
    };
    print("body is"+body.toString());



    try {
      response=await  dio.post("https://lakhani-khana-bachao-app.herokuapp.com/organizations", data: body);

      if(response.statusCode==201){
        print('response: ${response.data['organization_id']}');
        signUp(organizationId: response.data['organization_id'],usertype: userType);
        //setLoading(false);
      }
      else{
      print('Error: $response');
      setLoading(false);

      Fluttertoast.showToast(msg: AppStrings.SOME_THING, toastLength: Toast.LENGTH_SHORT);
      }
     // return response;
    } catch (e) {

      setLoading(false);
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_SHORT);

      print('Error: $e');
    }
  }
  Future<void> signUp({String? organizationId,String? usertype}) async {
    Response response;
    Dio dio = new Dio();
    Map<String,dynamic> body = {
      "name":_nameController.text,
      "email":_emailController.text,
      "password":_passwordController.text,
      "userType": usertype,
      "organization": organizationId
    };
    print("signup body is"+body.toString());




    try {
      response=await  dio.post("https://lakhani-khana-bachao-app.herokuapp.com/users", data: body);
        setLoading(false);
      if(response.statusCode==201){

        Fluttertoast.showToast(msg: "Sign up SuccessFully", toastLength: Toast.LENGTH_SHORT);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInScreen(fromNeedy: widget.fromNeedy,)));

        //setLoading(false);
      }
      else{
        Navigator.pop(context);
        print('Error: $response');
        setLoading(false);

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


  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    double height=media.height;
    double width=media.width;
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: height*0.1),
                  CustomLogoWidget(),
                  _signUpText(),
                  SizedBox(height: height*0.015,),
                  CustomTextFormFeild(hintText: AppStrings.NAME,controller: _nameController,),
                  CustomTextFormFeild(hintText: AppStrings.EMAIL,controller: _emailController,),
                 widget.fromNeedy!?Container(): CustomTextFormFeild(hintText: AppStrings.ORGANIZATION_NAME,controller: _organizationNameController,),
                  CustomTextFormFeild(hintText: AppStrings.CONTACT,controller: _phoneController,),
                  CustomTextFormFeild(hintText: AppStrings.PASSWORD,controller: _passwordController,),
                  CustomTextFormFeild(hintText: AppStrings.CONFIRM_PASSWORD,controller: _confirmPasswordController,),
                  SizedBox(height: height*0.015,),
                  _customJoinNowButton(height: height, width: width),
                  SizedBox(height: height*0.05,),
                  _alReadyAccount()


                ],
              ),
            ),
          ),
         ),

        isLoading ? Positioned.fill(child: ProcessLoading()) : Container(),
      ],
    );
  }

  Widget _signUpText(){
    return VariableText(
      text: AppStrings.SIGN_UP,
      fontfamily: AppFonts.PROMXIA_REGULAR,
      weight: FontWeight.w800,
      fontSize: 22,
      fontColor: AppColor.themeColorBlack,
    );
  }
  Widget _alReadyAccount(){
    return    InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInScreen()));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VariableText(
            text: AppStrings.ALREADY_ACCONT,
            fontfamily: AppFonts.PROMXIA_REGULAR,
            weight: FontWeight.w500,
            fontSize: 14,
            fontColor: AppColor.themeColorBlack,
          ),
          SizedBox(width: 5),
          VariableText(
            text: AppStrings.LOGIN,
            fontfamily: AppFonts.PROMXIA_REGULAR,
            weight: FontWeight.w600,
            fontSize: 15,
            fontColor: AppColor.themeColorPurple,
          ),
        ],
      ),
    );
  }
  Widget _customJoinNowButton({double? height,double? width}){
    return  InkWell(
      onTap: (){
        if(widget.fromNeedy!){
          if(validateNeedyFields()){

            createOrganization("CONSUMER");
          }
        }
        else{

       if(validateProviderFields()){
         createOrganization("SOURCE");
        }
        }
        //Navigator.push(context, MaterialPageRoute(builder: (_)=>MyHomePage()));
      },
      child: Container(
        width: width,
        height: height!*0.075,
        decoration: BoxDecoration(
            color: AppColor.themeColorPurple,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: VariableText(
            text: AppStrings.JOIN_NOW,
            fontColor: AppColor.themeColorWhite,
            fontfamily: AppFonts.PROMXIA_REGULAR,
            weight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
  bool validateProviderFields(){
    bool ok=false;
    if(_nameController.text.isNotEmpty){
    if(_emailController.text.isNotEmpty){
      if(_passwordController.text.isNotEmpty){
      if(_organizationNameController.text.isNotEmpty){
      if(_passwordController.text==_confirmPasswordController.text){
        ok=true;
      }
      else{
        Fluttertoast.showToast(msg: "PPassword and Confirm password must same", toastLength: Toast.LENGTH_SHORT);
      } }    else{
        Fluttertoast.showToast(msg: "Please Enter Organization Name", toastLength: Toast.LENGTH_SHORT);
      } }  else{
        Fluttertoast.showToast(msg: "Please Enter Password", toastLength: Toast.LENGTH_SHORT);
      } }
    else{
      Fluttertoast.showToast(msg: "Please Enter Email", toastLength: Toast.LENGTH_SHORT);
    } }
    else{
      Fluttertoast.showToast(msg: "Please Enter Name", toastLength: Toast.LENGTH_SHORT);
    }
    return ok;
  }
  bool validateNeedyFields(){
    bool ok=false;
    if(_nameController.text.isNotEmpty){
    if(_emailController.text.isNotEmpty){
      if(_passwordController.text.isNotEmpty){
        ok=true;
      }
      else{
        Fluttertoast.showToast(msg: "Please Enter Password", toastLength: Toast.LENGTH_SHORT);
      } }
    else{
      Fluttertoast.showToast(msg: "Please Enter Email", toastLength: Toast.LENGTH_SHORT);
    } }
    else{
      Fluttertoast.showToast(msg: "Please Enter Name", toastLength: Toast.LENGTH_SHORT);
    }
    return ok;
  }
}
