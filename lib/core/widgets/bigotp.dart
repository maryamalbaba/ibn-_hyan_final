import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';


class Bigotp extends StatelessWidget {
  const Bigotp({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      
       margin: const EdgeInsets.only(top: 10,bottom: 10),
      height: 35,
      width: (MediaQuery.of(context).size.width*0.8) ,
      decoration: BoxDecoration(
        border: Border.all(color: green),
        // color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: TextFormField(
textDirection:TextDirection.ltr,
          obscureText: false,
          
          decoration: InputDecoration(
            icon: Icon(Icons.mode,color: green,),
            isDense: true,
            border: InputBorder.none
          ),
          controller: controller,
         
          
        
        
          // style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
