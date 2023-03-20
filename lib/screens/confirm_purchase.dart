import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tes/custom_widgets/custom_logo_widget.dart';
import 'package:tes/custom_widgets/dialogs.dart';
import 'package:tes/custom_widgets/variable_text.dart';
import 'package:tes/models/food_data_model.dart';
import 'package:tes/provider/needy_provider.dart';
import 'package:tes/screens/receipt_screen.dart';
import 'package:tes/shared_preference.dart';
import 'package:tes/utils/app_color.dart';
import 'package:tes/utils/app_fonts.dart';
import 'package:tes/utils/app_strings.dart';

class ConfirmPurchaseScreen extends StatefulWidget {
  FoodData? fooddata;
  String? quantity;
   ConfirmPurchaseScreen({Key? key,this.fooddata,this.quantity}) : super(key: key);

  @override
  _ConfirmPurchaseScreenState createState() => _ConfirmPurchaseScreenState();
}

class _ConfirmPurchaseScreenState extends State<ConfirmPurchaseScreen> {
  bool _checkBox=true;
  bool _circularCheckBox=true;
String? token;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    token = SharedPreference().getBearerTokenForNeedy();
  }
  Future<void> createOrder() async {
    AppDialogs.progressAlertDialog(context: context);
    Response response;
    Dio dio = new Dio();
    Map<String,dynamic> body ={
      "food":widget.fooddata!.sId,
      "quantity": widget.quantity,
      "consumer":Provider.of<NeedyProvider>(context,listen: false).getCurrentNeedy!.sId,
      "source":widget.fooddata!.source,

    };
    print("body is"+body.toString());




    try {
      response=await  dio.post("https://lakhani-khana-bachao-app.herokuapp.com/orders", data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),);

      if(response.statusCode==201){

        Navigator.pop(context);

        Fluttertoast.showToast(msg: "Order created SuccessFully", toastLength: Toast.LENGTH_SHORT);

        Navigator.push(context, MaterialPageRoute(builder: (_)=>ReceiptScreen(fooddata: widget.fooddata,quantity: widget.quantity,)));
        //Navigator.push(context, MaterialPageRoute(builder: (_)=>SignInScreen(fromNeedy: widget.fromNeedy,)));

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
  @override
  Widget build(BuildContext context) {
    var media=MediaQuery.of(context).size;
    double height=media.height;
    double width=media.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.themeColorPurple,
        centerTitle: true,
        iconTheme:IconThemeData(
            color: AppColor.themeColorWhite
        ) ,
        title: VariableText(
          fontColor: AppColor.themeColorWhite,
          text: AppStrings.CONFIRM_PURCHASE,
          fontfamily: AppFonts.MONTSERRAT_BOLD,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height*0.01),
                  CustomLogoWidget(),
                 // SizedBox(height: height*0.02),

                  VariableText(
                    text: widget.fooddata!.name??"",
                    fontfamily: AppFonts.MONTSERRAT_BOLD,
                    fontSize: 17,
                    fontColor: AppColor.themeColorBlack,
                  ),
                  SizedBox(height: height*0.015),
                  VariableText(
                    text: AppStrings.MODERN,
                    fontfamily: AppFonts.MONTSERRAT_REGULAR,
                    fontSize: 12,
                    weight: FontWeight.w600,
                    fontColor: AppColor.themeColorBlack,
                  ),
                  //SizedBox(height: height*0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
                    child: Column(
                      children: [
                        Divider(thickness: 1,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                          child: Row(
                            children: [
                              Icon(Icons.fastfood_outlined,color: AppColor.themeColorPurple,size: 18,),
                              VariableText(
                                text: AppStrings.PORTION,
                                fontfamily: AppFonts.MONTSERRAT_REGULAR,
                                fontSize: 12,
                                fontColor: AppColor.themeColorBlack,
                              ),
                              Spacer(),
                              new Checkbox(
                                shape: CircleBorder(),
                                value: _circularCheckBox,

                                onChanged: (bool? newValue){
                                  setState(() {
                                    _circularCheckBox=newValue!;
                                  });
                                },
                                activeColor:AppColor.themeColorPurple,
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      decoration: BoxDecoration(
                        color: AppColor.themeColorPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add,color: AppColor.themeColorWhite),
                            SizedBox(width: 5),
                            VariableText(
                              text: AppStrings.ADD_MORE,
                              fontfamily: AppFonts.MONTSERRAT_REGULAR,
                              fontSize: 12,
                              fontColor: AppColor.themeColorWhite,
                            ),

                            // ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.all(8),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Checkbox(
                            value: _checkBox,
                            onChanged: (bool? value) {
                              setState(() {
                                _checkBox = value!;
                              });
                            },
                          ),
                        ),
                        VariableText(
                          text: AppStrings.WANT_TO_DONATE,
                          fontfamily: AppFonts.MONTSERRAT_MEDIUM,
                          weight: FontWeight.w700,
                          fontSize: 11,
                          fontColor: AppColor.themeColorBlack,
                        ),
                      ],
                    ),
                  ),
                  VariableText(
                    text: AppStrings.DETAILS,
                    fontfamily: AppFonts.MONTSERRAT_MEDIUM,
                    fontSize: 12,
                    weight: FontWeight.w600,
                    fontColor: AppColor.themeColorBlack,
                  ),
                  SizedBox(height: height*0.02),



                ],
              ),
            ),
          ),
          Column(
            children: [
              Divider(),
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.credit_card,color: AppColor.themeColorPurple,),
                    SizedBox(width: 5),
                    VariableText(
                      text: AppStrings.CARD_ENDING,
                      fontfamily: AppFonts.MONTSERRAT_MEDIUM,
                      weight: FontWeight.w600,
                      fontSize: 12,
                      fontColor:  AppColor.themeColorBlack,
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_down_sharp,color: AppColor.themeColorPurple)
                  ],
                ),

              ),
              InkWell(
                onTap: (){
                  createOrder();

                },
                child: Container(
                  color: AppColor.themeColorPurple,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.keyboard_arrow_right,color: AppColor.themeColorWhite,),
                        VariableText(
                          text: AppStrings.SLIDE_TO_CONFIRM,
                          fontfamily: AppFonts.MONTSERRAT_MEDIUM,
                          weight: FontWeight.w600,
                          fontSize: 12,
                          fontColor:  AppColor.themeColorWhite,
                        ),
                      ],
                    ),
                  ),

                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
