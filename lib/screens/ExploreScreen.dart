import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes/models/bottomNavBar.dart';
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  double f1ImageSize=20.0;
  double f2ImageSize=20.0;
  double f3ImageSize=20.0;

  Color f1ImageColor = Colors.red;
  Color f2ImageColor = Colors.greenAccent;
  Color f3ImageColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        f1ImageSize=160.0;
        f1ImageColor = Color(0xffd516b5);
        f2ImageColor = Color(0xff2fb0e1);
        f3ImageColor = Color(0xffffe376);
      });
    });
    var size =MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Text('Latest Uploads',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xffa606b1),decoration: TextDecoration.underline),)),
                SizedBox(height: size.height*0.05,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    decoration: BoxDecoration(
                        color: f1ImageColor,
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Downtown\nRestaurant',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                                SizedBox(height: size.height*0.01,),
                                Text('has 7 pieces of Beef\nburgers left go\npickup right now!',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
                                SizedBox(height: size.height*0.01,),
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Info',style: TextStyle(fontWeight: FontWeight.bold),),
                                        Icon(Icons.arrow_forward,color: Colors.black,),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Consumer<MyBottomNavBarModal>(
                            builder: (context,navBar,child){
                              return AnimatedContainer(
                                curve: Curves.linear,
                                width: f1ImageSize, // change width or height to see animation
                                height: 165.0,
                                duration: const Duration(seconds: 2),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/f1.png')
                                    )
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                            color: f2ImageColor,
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Container(
                            width: size.width*0.8,
                            child: Row(
                              children: [
                                Container(width: size.width*0.367,height: 100,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Farhan\nBiryani',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                                    Text('15 kilo biryani is available\nat Farhan biryani centre.',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
                                    SizedBox(height: size.height*0.01,),
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text('Info',style: TextStyle(fontWeight: FontWeight.bold),),
                                            Icon(Icons.arrow_forward,color: Colors.black,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 210,
                      child: Consumer<MyBottomNavBarModal>(
                        builder: (context,navBar,child){
                          return AnimatedContainer(
                            curve: Curves.linear,
                            width: f1ImageSize, // change width or height to see animation
                            height: 155.0,
                            duration: const Duration(seconds: 2),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                    image: AssetImage('assets/images/f1.png')
                                )
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('Near',style: TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold),),
                        Text('You !',style: TextStyle(fontSize: 40,color: Color(0xffa70ab2),fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: AnimatedContainer(
                            width: 150,
                            // height: 100,
                            duration: Duration(seconds: 1),
                            decoration: BoxDecoration(
                                color: f3ImageColor,
                                borderRadius: BorderRadius.circular(30.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('1 stop\njuice',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                                  Text('1 Stop juice has few \nglasses available go check\nout now!',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w400),),
                                  SizedBox(height: size.height*0.01,),
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Info',style: TextStyle(fontWeight: FontWeight.bold),),
                                          Icon(Icons.arrow_forward,color: Colors.black,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 90,
                          top: 20,
                          child: Consumer<MyBottomNavBarModal>(
                            builder: (context,navBar,child){
                              return RotatedBox(
                                quarterTurns: 1,
                                child: AnimatedContainer(
                                  curve: Curves.linear,
                                  width: f1ImageSize, // change width or height to see animation
                                  height: 155.0,
                                  duration: const Duration(seconds: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          image: AssetImage('assets/images/f3.png')
                                      )
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
