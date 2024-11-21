import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';


class OtpField extends StatelessWidget {
  const OtpField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.only(top: 10,bottom: 10),
      height: 35,
      width: (MediaQuery.of(context).size.width) / 11,
      decoration: BoxDecoration(
        border: Border.all(color: green),
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Center(
        child: TextFormField(
          obscureText: true,
          
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none
          ),
          controller: controller,
          textDirection: TextDirection.ltr,
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
          textAlign: TextAlign.center,
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          // style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
