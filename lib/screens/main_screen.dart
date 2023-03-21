import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tes/custom_widgets/dialogs.dart';
import 'package:tes/models/food_data_model.dart';
import 'package:tes/provider/needy_provider.dart';
import 'package:tes/screens/confirm_purchase.dart';
import 'package:tes/shared_preference.dart';
import 'package:tes/utils/app_color.dart';
import 'package:tes/utils/app_fonts.dart';
import 'package:tes/utils/app_strings.dart';

import 'role_selection_screen.dart';

class NeedyMainMenu extends StatefulWidget {

  @override
  State<NeedyMainMenu> createState() => _NeedyMainMenuState();
}

class _NeedyMainMenuState extends State<NeedyMainMenu> {

  List<String> imageList1 = ['','assets/p2.png'];
  List<String> imageList2 = ['assets/p3.png','assets/p4.png'];
  List<String> textList1 = ['Royall Hall','Pizza Night'];
  List<String> textList2 = ['Work Express','Kababjees'];
  List<Color> colorList1 = [Colors.red.shade900,Colors.cyan];
  List<Color> colorList2 = [Colors.orangeAccent,Colors.brown.shade700];
  bool seeMore = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  NeedyProvider? _needyProvider;
  String? slidervalue="0";
  String? token;
  List<FoodData>? _foodData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    token = SharedPreference().getBearerTokenForNeedy();
    print("token is "+token.toString());
    _foodData=[];
    getUserData();
    getFoodListData(token: token);
  }
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
  getFoodListData({String? token}) async {
    setLoading(true);
    Dio dio = new Dio();
  //  try {
      // final sharedPreferences = await SharedPreferences.getInstance();
      //final value = sharedPreferences.setString('accessToken', '');

      final res = await dio.get(
        'https://lakhani-khana-bachao-app.herokuapp.com/food',
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
        print("Data is"+res.data.toString());
       // _foodData=;

        for(var item in res.data){
          var foorItem = FoodData.fromJson(item);
          if(DateTime.parse(foorItem!.createdAt.toString()).add(Duration(hours: 12)).isAfter( DateTime.now())) {
            _foodData!.add(foorItem);
          }
        }
        print(_foodData!.length);
        // _foodData!.removeWhere((element) => );
        setState(() {

        });
        setLoading(false);

        print("Data is"+_foodData!.length.toString());


      }
      else{
        setLoading(false);
      }
 /*   }
    catch (e) {
      print(e);
    }*/
  }

getUserData(){

  _needyProvider = Provider.of<NeedyProvider>(context,listen: false);
  /*  if(_needyProvider?.getCurrentNeedy != null)
    {
      _sellerDataModel = _sellerProvider?.getCurrentSeller?.data;

    }*/


}

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Future.delayed(const Duration(milliseconds: 10), () {
          exit(0);
        });

      },
      child: Scaffold(
        key: scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:AppColor.themeColorPurple,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon:  Icon(Icons.home),
              label: 'Call',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined),
              label: 'Message',
              backgroundColor: Colors.green, // <-- This works for shifting
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Call',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Message',
              backgroundColor: Colors.green, // <-- This works for shifting
            ),
          ],
        ),
        drawer:  Container(
          width:width,
          height: height,
          color:AppColor.themeColorPurple,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                height: height*0.2,
                child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.menu_open,color: Colors.white60,)),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                child: Container(
                  height: height*0.8,
                  width: width,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        height: height*0.08,
                        color: Colors.grey.shade100,
                        padding: EdgeInsets.only(left: width*0.12,top: height*0.03),
                        child: Text(_needyProvider?.getCurrentNeedy!.name??"",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: AppFonts.PROMXIA_REGULAR),),
                      ),
                      Container(
                        width: width,
                        height: height*0.06,
                        padding: EdgeInsets.only(left: width*0.12,top: height*0.02),
                        child: Text('My Profile',style: TextStyle(fontSize: 16,color: Colors.grey.shade600,fontFamily: AppFonts.PROMXIA_REGULAR),),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        width: width,
                        height: height*0.06,
                        padding: EdgeInsets.only(left: width*0.12,top: height*0.02),
                        child: Text('Favourites',style: TextStyle(fontSize: 16,color: Colors.grey.shade600,fontFamily: AppFonts.PROMXIA_REGULAR),),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        width: width,
                        height: height*0.06,
                        padding: EdgeInsets.only(left: width*0.12,top: height*0.02),
                        child: Text('Addresses',style: TextStyle(fontSize: 16,color: Colors.grey.shade600,fontFamily: AppFonts.PROMXIA_REGULAR),),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        width: width,
                        height: height*0.06,
                        padding: EdgeInsets.only(left: width*0.12,top: height*0.02),
                        child: Text('About Us',style: TextStyle(fontSize: 16,color: Colors.grey.shade600,fontFamily: AppFonts.PROMXIA_REGULAR),),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        width: width,
                        height: height*0.06,
                        padding: EdgeInsets.only(left: width*0.12,top: height*0.02),
                        child: Text('Help',style: TextStyle(fontSize: 16,color: Colors.grey.shade600,fontFamily: AppFonts.PROMXIA_REGULAR),),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        width: width,
                        height: height*0.06,
                        padding: EdgeInsets.only(left: width*0.12,top: height*0.02),
                        child: Text('Google',style: TextStyle(fontSize: 16,color: Colors.red.shade400,fontFamily: AppFonts.PROMXIA_REGULAR),),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        width: width,
                        height: height*0.06,
                        padding: EdgeInsets.only(left: width*0.12,top: height*0.02),
                        child: Text('Facebook',style: TextStyle(fontSize: 16,color: Colors.blue.shade400,fontFamily: AppFonts.PROMXIA_REGULAR),),
                      ),
                      Divider(thickness: 1,),
                      InkWell(
                        onTap: (){
                          logOut();
                        },
                        child: Container(
                          width: width,
                          height: height*0.06,
                          padding: EdgeInsets.only(left: width*0.12,top: height*0.02),
                          child: Text('Log out',style: TextStyle(fontSize: 16,color: Colors.grey.shade600,fontFamily: AppFonts.PROMXIA_REGULAR),),
                        ),
                      ),
                      Divider(thickness: 1,),












                      SizedBox(height: height*0.0,),
                      Center(child: Text('Copyrights@',style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: Colors.grey.shade500),),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children:  [
            Row(
              children: [
                Container(
                  width: width*0.15,
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.menu,color: Colors.grey.shade500,), onPressed: () {
                      print('printing');
                      scaffoldKey.currentState!.openDrawer();
                    },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: height*0.03, right: width*0.02),
                  width: width*0.8,
                  height: height*0.08,
                  child: TextField(
                    cursorColor: Colors.black,
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
                        hintText: "Search for food nearby",
                        hintStyle: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: Colors.grey.shade500),
                        prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,)
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: width*0.05,top: height*0.02),
                width: width,
                child: Text('All Restaurants',style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,fontSize: 18,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
            isLoading?
            Center(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: CircularProgressIndicator(color: AppColor.themeColorPurple,),
            ),):
            Expanded(
              child: GridView.builder(
                itemCount:  _foodData!.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int ind) {
                  return
                  Column(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap:(){
                              // var time = _foodData![ind].createdAt;
                              // print(DateTime.parse(_foodData![ind].createdAt.toString()));
                              var time = DateTime.parse(_foodData![ind].createdAt.toString());
                              if(time.add(Duration(hours: 12)).isAfter(DateTime.now()))
                               {
                                 _settingModalBottomSheet(context,_foodData![ind]);
                               }
                              else{
                                showDialog(
                                    context: context,
                                    builder: (_) =>  Center(
                                  child: Container(
                                  // width: size.width * 0.5,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.done,size: 40.0,color: Color(0xffa606b1),),
                                        SizedBox(height:10,),
                                        Text('Food Expired',style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                                );

                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: width*0.05,right: width*0.05),
                              padding: EdgeInsets.only(bottom: 10),
                              height: height*0.2,
                              width: width*0.5,
                              decoration: BoxDecoration(

                                  color: Colors.red.shade900,
                                  image: DecorationImage(
                                      image: AssetImage('assets/p1.png')
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Wrap(
                                children: [
                                  Align(
                                    alignment:Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.only(top: height*0.05),
                                      width: width*0.2,
                                      height: height*0.05,
                                      color:AppColor.themeColorPurple,
                                      child: Center(child: Text('${ _foodData![ind].currentQuantity.toString().split(".")[0]} pcs',style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: Colors.white,fontWeight: FontWeight.bold),),),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: height*0.05),
                                      height: height*0.1,
                                      child: Text( _foodData![ind].name.toString(),style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,)
                    ],
                  );
                },
              ),
            ),
/*          Container(
                margin: EdgeInsets.only(top: height*0.02),
                //height: height*0.2,
                width: width,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _foodData!.length,
                  shrinkWrap: true,
                  itemBuilder: (context,ind){
                    return
                      _foodData!.isNotEmpty?
                      Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap:(){
                                _settingModalBottomSheet(context,_foodData![ind]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: width*0.05),
                                padding: EdgeInsets.only(bottom: 10),
                                height: height*0.2,
                                width: width*0.5,
                                decoration: BoxDecoration(

                                    color: Colors.red.shade900,
                                    image: DecorationImage(
                                        image: AssetImage('assets/p1.png')
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Wrap(
                                  children: [
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(top: height*0.05),
                                        width: width*0.2,
                                        height: height*0.05,
                                        color:AppColor.themeColorPurple,
                                        child: Center(child: Text('${ _foodData![ind].currentQuantity} pcs',style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: Colors.white,fontWeight: FontWeight.bold),),),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(top: height*0.05),
                                        height: height*0.1,
                                        child: Text( _foodData![ind].name.toString(),style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],
                    ):
                      Center(child: CircularProgressIndicator(),);
                  },
                )),*/
            /*

            Container(
                margin: EdgeInsets.only(top: height*0.02),
                height: height*0.2,
                width: width,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context,ind){
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: width*0.05),
                          padding: EdgeInsets.only(bottom: 10),
                          height: height*0.2,
                          width: width*0.5,
                          decoration: BoxDecoration(
                              color: colorList2[ind],
                              image: DecorationImage(
                                  image: AssetImage(imageList2[ind])
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Wrap(
                            children: [
                              Align(
                                alignment:Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: height*0.05),
                                  width: width*0.2,
                                  height: height*0.05,
                                  color:AppColor.themeColorPurple,
                                  child: Center(child: Text('15 pcs',style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: Colors.white,fontWeight: FontWeight.bold),),),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  margin: EdgeInsets.only(top: height*0.05),
                                  height: height*0.1,
                                  child: Text(textList2[ind],style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
              padding: EdgeInsets.only(bottom: 10),
              height: height*0.22,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  image: DecorationImage(
                      image: AssetImage('assets/p2.png')
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Wrap(
                children: [
                  Align(
                    alignment:Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: height*0.05),
                      width: width*0.2,
                      height: height*0.05,
                      color:AppColor.themeColorPurple,
                      child: Center(child: Text('15 pcs',style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: Colors.white,fontWeight: FontWeight.bold),),),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: height*0.07),
                      height: height*0.1,
                      child: const Text('Hot and Roll',style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            seeMore? Wrap(children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                padding: EdgeInsets.only(bottom: 10),
                height: height*0.22,
                width: width,
                decoration: const BoxDecoration(
                    color: Colors.pink,
                    image: DecorationImage(
                        image: AssetImage('assets/p1.png')
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Wrap(
                  children: [
                    Align(
                      alignment:Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: height*0.05),
                        width: width*0.2,
                        height: height*0.05,
                        color:AppColor.themeColorPurple,
                        child: Center(child: Text('15 pcs',style: TextStyle(fontFamily: AppFonts.PROMXIA_REGULAR,color: Colors.white,fontWeight: FontWeight.bold),),),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: height*0.07),
                        height: height*0.1,
                        child: const Text('Spiecy Bite',style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: AppFonts.PROMXIA_REGULAR,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                padding: EdgeInsets.only(bottom: 10),
                height: height*0.22,
                width: width,
                decoration: const BoxDecoration(
                    color: Colors.black54,
                    image: DecorationImage(
                        image: AssetImage('assets/p4.png')
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Wrap(
                  children: [
                    Align(
                      alignment:Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: height*0.05),
                        width: width*0.2,
                        height: height*0.05,
                        color:AppColor.themeColorPurple,
                        child: Center(child: Text('15 pcs',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: AppFonts.PROMXIA_REGULAR,),),),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: height*0.07),
                        height: height*0.1,
                        child: const Text('BBQ Tonight',style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: AppFonts.PROMXIA_REGULAR,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                padding: EdgeInsets.only(bottom: 10),
                height: height*0.22,
                width: width,
                decoration: const BoxDecoration(
                    color: Colors.yellowAccent,
                    image: DecorationImage(
                        image: AssetImage('assets/p3.png')
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Wrap(
                  children: [
                    Align(
                      alignment:Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(top: height*0.05),
                        width: width*0.2,
                        height: height*0.05,
                        color:AppColor.themeColorPurple,
                        child: Center(child: Text('15 pcs',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: AppFonts.PROMXIA_REGULAR,),),),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(top: height*0.07),
                        height: height*0.1,
                        child: const Text('Food Junky',style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: AppFonts.PROMXIA_REGULAR,
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ],):Container(),
            GestureDetector(
              onTap: (){
                setState(() {
                  seeMore = !seeMore;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Icon(seeMore ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded ,color:AppColor.themeColorPurple,),
                  Text(seeMore? 'See Less' : 'See More',style: TextStyle(color:AppColor.themeColorPurple,fontFamily: AppFonts.PROMXIA_REGULAR,),)
                ],
              ),
            )
            */
          ],
        ),
      ),
    );
  }
  void _settingModalBottomSheet(context,FoodData fooddata){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.hardEdge,
        isScrollControlled: true,
        backgroundColor: Colors.black12,
        builder: (BuildContext context){
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate)
           =>Container(
              width: width,
              height: height,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 20,left: 10),
                      alignment: Alignment.topLeft,
                      width: width,
                      height: height,
                      color: Colors.black12,
                      child: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back,color: Colors.white,)),
                    ),
                  ),
                  Container(
                    width: width,
                    height: height*0.7,
                    margin: EdgeInsets.only(top: height*0.3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                    ),
                    child: Column(children: [
                      Container(
                        width: width,
                        height: height*0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/p1.png'),
                                fit: BoxFit.fill
                            ),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: width*0.05,top: height*0.03),
                          width: width,
                          child: Text(fooddata.name??"",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,fontFamily: AppFonts.PROMXIA_REGULAR,),textAlign: TextAlign.start,)),
                      Container(
                          margin: EdgeInsets.only(left: width*0.05,top: height*0.01),
                          width: width,
                          child: Text('Royal Hall has 4 pieces of chikken handi left',style: TextStyle(fontSize: 12,color: Colors.grey.shade500,fontFamily: AppFonts.PROMXIA_REGULAR,),textAlign: TextAlign.start,)),
                      Row(
                        children: [

                          SliderTheme(
                            data:SliderTheme.of(context).copyWith(
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 8.0,
                                pressedElevation: 4.0,
                              ),
                              overlayColor: Colors.black,
                            ),
                            child: Slider(

                              min: 0.0,
                              max: checkDouble(fooddata.currentQuantity),
                              value: double.parse(slidervalue.toString()),
                              activeColor:AppColor.themeColorPurple,
                              inactiveColor: Colors.grey.shade500,
                              thumbColor: Colors.white,
                              onChanged: (value) {
                                print("value is"+value.toString());

                                mystate(() {
                                  slidervalue=value.toString();
                                  // _value = value;
                                });
                              },
                            ),
                          ),
                          Text('${slidervalue.toString().split(".")[0]} Pieces',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:AppColor.themeColorPurple,fontFamily: AppFonts.PROMXIA_REGULAR,),textAlign: TextAlign.start),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width*0.4,
                            child: ElevatedButton(
                              onPressed: () {

                                Navigator.push(context, MaterialPageRoute(builder: (_)=>ConfirmPurchaseScreen(fooddata: fooddata,quantity: slidervalue,)));
                              },
                              child: Text('Add to cart',style: TextStyle(
                                color: AppColor.themeColorWhite,
                                fontFamily: AppFonts.PROMXIA_REGULAR
                              ),),
                              style: ElevatedButton.styleFrom(
                                primary:AppColor.themeColorPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  // <-- Radius
                                ),
                              ),
                            ),
                          ),
                          Container(
                              width: width*0.4, child: Text('Expiry Date: 1 day left',style: TextStyle(fontSize: 14,color: Colors.grey.shade500,fontFamily: AppFonts.PROMXIA_REGULAR,),textAlign: TextAlign.start,)),
                        ],
                      )
                    ],),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  Future<void> logOut() async {
    AppDialogs.progressAlertDialog(context: context);
    Response response;
    Dio dio = new Dio();




    try {
      response=await  dio.post("http://192.168.3.102:3000/users/logout", data: null,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),);

      if(response.statusCode==200){
Navigator.pop(context);
        Fluttertoast.showToast(msg: "Log out SuccessFully", toastLength: Toast.LENGTH_SHORT);
Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (BuildContext context) => SelectType()),
        (Route<dynamic> route) => false);
        SharedPreference().clear();
        Provider.of<NeedyProvider>(context,listen: false).setCurrentNeedyFromSharedPreference(user: null);

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
  static double checkDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }
}

