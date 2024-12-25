import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';

class ErrorUi extends StatelessWidget {
   ErrorUi({super.key});

  @override
  Widget build(BuildContext context) {
    return
       Padding(
         padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
         child: Center(child: Image.asset(error_Image),),
       );
    
  }
}