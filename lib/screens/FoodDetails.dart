import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tes/custom_widgets/dialogs.dart';
import 'package:tes/provider/customSlider.dart';
import 'package:tes/provider/provider.dart';
import 'package:tes/shared_preference.dart';
import 'package:tes/urls/url_constants.dart';
import 'package:tes/utils/app_strings.dart';
class FoodDetails extends StatefulWidget {
  FoodDetails({Key? key}) : super(key: key);

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  TextEditingController name = TextEditingController();

  TextEditingController foodType = TextEditingController();

  TextEditingController amountOfFood = TextEditingController();

  TextEditingController number = TextEditingController();

  TextEditingController pickupAddress = TextEditingController();
  String? token;
  String? slidervalue;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    token = SharedPreference().getBearerTokenForProvider();
  }

  Future<void> createFood() async {
    AppDialogs.progressAlertDialog(context: context);
    Response response;
    Dio dio = new Dio();
    Map<String,dynamic> body = {
      "name":foodType.text,
      "original_quantity": slidervalue,
      "source":Provider.of<ProvidersProvider>(context,listen: false).getCurrentProvider!.sId,
      "current_quantity": slidervalue??0,
      "expiry": selectedDate.millisecondsSinceEpoch
    };
    print("body is"+body.toString());




    try {
      response=await  dio.post("${Constantsurl.CONSTANT_URL}/food", data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),);
      print(response.data.toString());
      if(response.statusCode==201){

        Navigator.pop(context);
        showDialog(context: context, builder: (context){
          return Center(
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
                    Text('Food Supply posted',style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          );
        });
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
  bool validateFields(){
    bool ok=false;
    if(foodType.text.isNotEmpty){
      if(slidervalue!=null){
      if(selectedDate!=null){
        ok=true;
      }
      else{
        Fluttertoast.showToast(msg: "Please Select Date", toastLength: Toast.LENGTH_SHORT);
      } }  else{
        Fluttertoast.showToast(msg: "Please Select Pieces", toastLength: Toast.LENGTH_SHORT);
      } }
    else{
      Fluttertoast.showToast(msg: "Please Enter Food Type", toastLength: Toast.LENGTH_SHORT);
    }
    return ok;
  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: (){Navigator.pop(context);},
                        child: Icon(Icons.arrow_back,color: Colors.transparent,size: 35,)),
                    Image(
                      image: AssetImage('assets/images/khana bachao logo pg.png'),
                      width: size.width*0.3,
                    ),
                  ],
                ),
                SizedBox(height: size.height*0.05,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                  child: Text('Enter Your Food Details',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                  child: Text('Help The Nearby',style: TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w400)),
                ),
                SizedBox(height: size.height*0.03,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                          labelText: '  Enter Restaurant Name',
                          labelStyle: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 15,fontWeight: FontWeight.w400)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: TextField(
                      controller: foodType,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: '  Enter Food Type',
                          labelStyle: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 15,fontWeight: FontWeight.w400)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: TextField(
                      controller: amountOfFood,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: '  Enter Amount of Food',
                          labelStyle: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 15,fontWeight: FontWeight.w400)
                      ),
                    ),
                  ),
                ),
                Consumer<CustomSlider>(
                  builder: (context,cs,child){
                    return Slider(
                        min: 10.0,
                        max: 100.0,
                        inactiveColor: Color(0xffa606b1),
                        activeColor: Color(0xffa606b1),
                        thumbColor: Color(0xffa606b1),

                        value: cs.value ?? 10.0,
                        onChanged: (val){
                          slidervalue=val.toString();
                          setState(() {

                          });
                          cs.changeValue(val);
                        }
                    );
                  }
                ),
                Consumer<CustomSlider>(
                  builder: (context,cs,child){
                    return Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,0.0,15.0,15.0),
                        child: Text(
                          cs.value!=null?cs.value!.round().toString()+' pieces':'10.0'+' pieces',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Color(0xffa606b1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: InkWell(
                      onTap: () async {
                        // final DateTime? picked = await showDatePicker(
                        //   context: context,
                        //   initialDate: DateTime.now(), // Refer step 1
                        //   firstDate: DateTime(2000),
                        //   lastDate: DateTime(2025),
                        // );
                        // if (picked != null && picked != selectedDate)
                        //   setState(() {
                        //     selectedDate = picked;
                        //   });

                      },
                      child: TextField(
                        controller: number,
                        // enabled: false,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText:selectedDate!=null?selectedDate.toString().split(" ")[0]: 'Food details',
                            labelStyle: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 15,fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: TextField(
                      controller: pickupAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: '  Pickup Address',
                          labelStyle: TextStyle(color: Colors.black.withOpacity(0.4),fontSize: 15,fontWeight: FontWeight.w400)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: ()async{
                        if(validateFields()){
                        createFood();}
                       // _submitForm(name.text,foodType.text,amountOfFood.text,number.text,pickupAddress.text,context);

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffa606b1),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text('SUBMIT FORM',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.05,),
              ],
            ),
          ),
        ),
      )
    );
  }
}
