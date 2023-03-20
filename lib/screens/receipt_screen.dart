import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes/custom_widgets/variable_text.dart';
import 'package:tes/models/food_data_model.dart';
import 'package:tes/provider/needy_provider.dart';
import 'package:tes/screens/main_screen.dart';
import 'package:tes/screens/receipt_screen.dart';
import 'package:tes/utils/app_color.dart';
import 'package:tes/utils/app_fonts.dart';
import 'package:tes/utils/app_strings.dart';

class ReceiptScreen extends StatefulWidget {

  FoodData? fooddata;
  String? quantity;
  ReceiptScreen({Key? key,this.fooddata,this.quantity}) : super(key: key);

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    double height = media.height;
    double width = media.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.themeColorPurple,
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColor.themeColorWhite),
          title: VariableText(
            fontColor: AppColor.themeColorWhite,
            text: AppStrings.RECEIPT,
            fontfamily: AppFonts.MONTSERRAT_BOLD,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(Icons.share),
            )
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  Center(
                    child: VariableText(
                      text: Provider.of<NeedyProvider>(context,listen: false).getCurrentNeedy!.name??"",
                      fontfamily: AppFonts.MONTSERRAT_MEDIUM,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w700,
                      fontSize: 12,
                      fontColor: AppColor.themeColorBlack,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Center(
                    child: VariableText(
                      text: AppStrings.DATE,
                      fontfamily: AppFonts.MONTSERRAT_REGULAR,
                      textAlign: TextAlign.center,
                      fontSize: 11,
                      fontColor: AppColor.themeColorBlack,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    height: height * 0.12,
                    //   color: Colors.blueGrey,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            VariableText(
                              text: widget.fooddata!.name??"",
                              fontfamily: AppFonts.MONTSERRAT_BOLD,
                              fontSize: 17,
                              fontColor: AppColor.themeColorBlack,
                            ),
                            SizedBox(height: height * 0.005),
                            Center(
                              child: VariableText(
                                text: AppStrings.DETAILS_TWO,
                                fontfamily: AppFonts.MONTSERRAT_REGULAR,
                                textAlign: TextAlign.center,
                                weight: FontWeight.w600,
                                fontSize: 10,
                                fontColor: AppColor.themeColorBlack,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.fastfood_outlined,
                                  color: AppColor.themeColorPurple,
                                  size: 16,
                                ),
                                VariableText(
                                  text: widget.quantity??"",
                                  fontfamily: AppFonts.MONTSERRAT_REGULAR,
                                  fontSize: 12,
                                  weight: FontWeight.w600,
                                  fontColor: AppColor.themeColorBlack,
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.014),
                            Divider(
                              thickness: 1,
                            ),
                          ],
                        ),
                        Positioned(
                          top: height * 0.069,
                          child: Padding(
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
                                    VariableText(
                                      text: "5.00 ",
                                      fontfamily: AppFonts.MONTSERRAT_REGULAR,
                                      fontSize: 12,
                                      fontColor: AppColor.themeColorWhite,
                                    ),

                                    Icon(
                                      Icons.euro,
                                      color: AppColor.themeColorWhite,
                                      size: 12,
                                    ),

                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: AppColor.themeColorPurple,
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VariableText(
                              text: AppStrings.MODERN,
                              fontfamily: AppFonts.MONTSERRAT_REGULAR,
                              fontSize: 10,
                              weight: FontWeight.w600,
                              fontColor: AppColor.themeColorPurple,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            VariableText(
                              text: AppStrings.PICK_IT,
                              fontfamily: AppFonts.MONTSERRAT_REGULAR,
                              fontSize: 9,
                              fontColor: AppColor.themeColorBlack,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColor.themeColorBlack,
                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VariableText(
                              text: AppStrings.PICK_UP,
                              fontfamily: AppFonts.MONTSERRAT_REGULAR,
                              fontSize: 10,
                              weight: FontWeight.w600,
                              fontColor: AppColor.themeColorBlack,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            VariableText(
                              text: AppStrings.PICK_IT,
                              fontfamily: AppFonts.MONTSERRAT_REGULAR,
                              fontSize: 9,
                              fontColor: AppColor.themeColorBlack,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Divider(
                    height: 0,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: width,
                height: height,

                decoration: BoxDecoration(
                  // color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage('assets/images/map.jpg',),
                        fit: BoxFit.cover
                    )
                ),
                child: Stack(
                  children: [
                   // Image.asset('assets/images/map.jpg', fit: BoxFit.cover),
                    InkWell(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (_)=>NeedyMainMenu()));
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 19.0),
                          child: Container(
                            color: AppColor.themeColorPurple,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 12),
                              child: VariableText(
                                text: AppStrings.DIRECTION,
                                weight: FontWeight.w600,
                                fontColor: AppColor.themeColorWhite,
                                fontfamily: AppFonts.MONTSERRAT_MEDIUM,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
