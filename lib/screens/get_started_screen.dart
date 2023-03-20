import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes/custom_widgets/custom_logo_widget.dart';
import 'package:tes/provider/needy_provider.dart';
import 'package:tes/provider/provider.dart';
import 'package:tes/screens/main_screen.dart';
import 'package:tes/screens/provider_bottom_bar.dart';
import 'package:tes/screens/role_selection_screen.dart';
import 'package:tes/shared_preference.dart';
import 'package:tes/utils/app_color.dart';
import 'package:tes/utils/app_fonts.dart';

import '../custom_widgets/variable_text.dart';
import '../utils/app_strings.dart';
class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  NeedyProvider? _needyProvider;
  ProvidersProvider? _providersProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
       _checkCurrentUserMethod();
    });
  }
  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    double height=media.height;
    double width=media.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: height*0.05,),
              CustomLogoWidget(),
               SizedBox(height: height*0.05,),
              Center(
                child: Container(
                  height: height*0.5,
                  child: Image(
                    image: AssetImage('assets/images/child.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
               SizedBox(height: height*0.05,),
              _customGetStartedButton(height: height, width: width,context: context),

            ],
          ),
        ),
      ),
    );
  }

  void _checkCurrentUserMethod() async
  {
    await SharedPreference().sharedPreference;
    print("data is"+SharedPreference().getNeedy().toString());


    if(SharedPreference().getNeedy() != null)
    {//assign reference to user provider
      _needyProvider = Provider.of<NeedyProvider>(context,listen: false);
      //set login response to user provider method
      _needyProvider!.setCurrentNeedyFromSharedPreference(user: SharedPreference().getNeedy());
      Navigator.push(context, MaterialPageRoute(builder: (_)=>NeedyMainMenu()));

    }
    else   if(SharedPreference().getProvider() != null)
    {

      //assign reference to user provider
      _providersProvider = Provider.of<ProvidersProvider>(context,listen: false);
      //set login response to user provider method
      _providersProvider!.setCurrentProviderFromSharedPreference(user: SharedPreference().getProvider());


      Navigator.push(context, MaterialPageRoute(builder: (_)=>ProviderMainMenu()));

    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SelectType()));
    }

  }

  Widget _customGetStartedButton({double? height,double? width,BuildContext? context}){
    return  InkWell(
      onTap: (){
        Navigator.push(context!, MaterialPageRoute(builder: (context)=>SelectType()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: width,
          height: height!*0.075,
          decoration: BoxDecoration(
              color: AppColor.themeColorPurple,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: VariableText(
              text: AppStrings.GET_STARTED,
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
