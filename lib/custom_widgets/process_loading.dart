import 'package:flutter/material.dart';
import 'package:tes/utils/app_color.dart';

class ProcessLoading extends StatefulWidget{

  @override
  State createState() {
    return _ProcessLoadingState();
  }
}

class _ProcessLoadingState extends State<ProcessLoading> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return Container(color:Color.fromRGBO(0, 0, 0, 0.5),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColor.themeColorPurple,
          ),
        ));
  }
}
