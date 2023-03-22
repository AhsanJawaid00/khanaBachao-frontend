import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/custom_widgets/custom_logo_widget.dart';
import 'package:tes/custom_widgets/custom_text_field.dart';
import 'package:tes/custom_widgets/dialogs.dart';
import 'package:tes/custom_widgets/variable_text.dart';
import 'package:tes/provider/needy_provider.dart';
import 'package:tes/provider/provider.dart';
import 'package:tes/screens/main_screen.dart';
import 'package:tes/screens/provider_bottom_bar.dart';
import 'package:tes/screens/receipt_screen.dart';
import 'package:tes/screens/sign_up_screen.dart';
import 'package:tes/shared_preference.dart';
import 'package:tes/urls/url_constants.dart';
import 'package:tes/utils/app_color.dart';
import 'package:tes/utils/app_fonts.dart';
import 'package:tes/utils/app_strings.dart';

class SignInScreen extends StatefulWidget {
  bool? fromNeedy;
  SignInScreen({Key? key, this.fromNeedy}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  NeedyProvider? _needyProvider;
  ProvidersProvider? _providersProvider;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> signIn({String? organizationId}) async {
    AppDialogs.progressAlertDialog(context: context);
    Response response;
    Dio dio = new Dio();
    Map<String, dynamic> body = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };

    try {
      print(json.encode(body));
      response = await dio.post("${Constantsurl.CONSTANT_URL}/users/login",
          data: json.encode(body),
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ));
      print("Hello ${response}");

      if (response.statusCode == 200) {
        if (widget.fromNeedy!) {
          print("needy ${widget.fromNeedy!}");
          SharedPreference()
              .setBearerTokenForNeedy(token: response.data['token'].toString());
          getuserData(token: response.data['token'].toString());
        } else {
          print("needy2 ${widget.fromNeedy!}");
          print("needy token ${response.data['token']}");
          SharedPreference().setBearerTokenForProvider(
              token: response.data['token'].toString());
          getuserData(token: response.data['token'].toString());
        }
        //  Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInScreen(fromNeedy: widget.fromNeedy,)));

        //setLoading(false);
      } else {
        Navigator.pop(context);
        print('Error: $response');

        Fluttertoast.showToast(
            msg: AppStrings.SOME_THING, toastLength: Toast.LENGTH_SHORT);

        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(), toastLength: Toast.LENGTH_SHORT);
      Navigator.pop(context);
      // setLoading(false);
      print('Error: $e');
    }
  }

  getuserData({String? token}) async {
    Dio dio = new Dio();
    try {
      // final sharedPreferences = await SharedPreferences.getInstance();
      //final value = sharedPreferences.setString('accessToken', '');

      final res = await dio.get(
        '${Constantsurl.CONSTANT_URL}/users/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      print('-----------------------');
      //  print(value);
      print('-----------------------');

      if (res.statusCode == 200) {
        print("Data is" + res.data.toString());
        if (widget.fromNeedy!) {
          _needyProvider = Provider.of<NeedyProvider>(context, listen: false);

          //set login response to user provider method
          _needyProvider?.setCurrentNeedy(user: res.data);
          SharedPreference().setNeedy(user: jsonEncode(res.data));
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Sign in SuccessFully", toastLength: Toast.LENGTH_SHORT);

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NeedyMainMenu()));
        } else {
          _providersProvider =
              Provider.of<ProvidersProvider>(context, listen: false);

          //set login response to user provider method
          _providersProvider?.setCurrentProvider(user: res.data);
          SharedPreference().setProvider(seller: jsonEncode(res.data));

          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: "Sign in SuccessFully", toastLength: Toast.LENGTH_SHORT);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ProviderMainMenu()));
        }

        //  customerDataList.value = res.data['data']['customer_info'];
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double height = media.height;
    double width = media.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: height * 0.1),
              CustomLogoWidget(),
              _signInText(),
              SizedBox(
                height: height * 0.015,
              ),
              CustomTextFormFeild(
                hintText: AppStrings.EMAIL,
                controller: _emailController,
              ),
              CustomTextFormFeild(
                hintText: AppStrings.PASSWORD,
                controller: _passwordController,
              ),
              SizedBox(
                height: height * 0.015,
              ),
              _customLoginButton(height: height, width: width),
              SizedBox(
                height: height * 0.05,
              ),
              _dontAccount()
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInText() {
    return VariableText(
      text: AppStrings.SIGN_IN,
      fontfamily: AppFonts.PROMXIA_REGULAR,
      weight: FontWeight.w800,
      fontSize: 22,
      fontColor: AppColor.themeColorBlack,
    );
  }

  Widget _customLoginButton({double? height, double? width}) {
    return InkWell(
      onTap: () {
        if (validateFields()) {
          signIn();
          // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyHomePage()));
        }
      },
      child: Container(
        width: width,
        height: height! * 0.075,
        decoration: BoxDecoration(
            color: AppColor.themeColorPurple,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: VariableText(
            text: AppStrings.LOGIN,
            fontColor: AppColor.themeColorWhite,
            fontfamily: AppFonts.PROMXIA_REGULAR,
            weight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _dontAccount() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SignUpScreen(
                      fromNeedy: widget.fromNeedy,
                    )));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VariableText(
            text: AppStrings.DONOT_ACCONT,
            fontfamily: AppFonts.PROMXIA_REGULAR,
            weight: FontWeight.w500,
            fontSize: 14,
            fontColor: AppColor.themeColorBlack,
          ),
          SizedBox(width: 5),
          VariableText(
            text: AppStrings.SIGN_UP,
            fontfamily: AppFonts.PROMXIA_REGULAR,
            weight: FontWeight.w600,
            fontSize: 15,
            fontColor: AppColor.themeColorPurple,
          ),
        ],
      ),
    );
  }

  bool validateFields() {
    bool ok = false;
    if (_emailController.text.isNotEmpty) {
      if (_passwordController.text.isNotEmpty) {
        ok = true;
      } else {
        Fluttertoast.showToast(
            msg: "Please Enter Password", toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please Enter Email", toastLength: Toast.LENGTH_SHORT);
    }
    return ok;
  }
}
