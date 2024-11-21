import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/auth/view/sign_page.dart';


// ignore: camel_case_types
class welcomePage extends StatelessWidget {
  const welcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
          decoration: BoxDecoration(
            color: offwhite,
            image: const DecorationImage(
              
              image: AssetImage(background),fit: BoxFit.fill),
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.end,
            
            
            children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child:InkWell(

                onTap:(){
                  print("fffffff");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignPage()));
                } ,
                child: const Useable_Green_container(text: "تسجيل الدخول",))
              
              )
          ],) ),
    );
  }
}
