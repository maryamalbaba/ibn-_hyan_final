import 'dart:io';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/core_page.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/resourses/styles_manager.dart';
import 'package:ibnhyanfinal/core/widgets/bigotp.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/auth/bloc/auth_bloc.dart';
import 'package:ibnhyanfinal/feature/auth/model/usermodel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ibnhyanfinal/feature/auth/view/platform/device_id.dart';

class SignPage extends StatefulWidget {
  SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController controller1 = TextEditingController();



Future<String>loadeviceId()async{
  
 String  id= await getDeviceId();;
 return id;
  
}


  @override
  Widget build(BuildContext context) {
   ///device func
  
   
   //
    final screenwidth = MediaQuery.of(context).size.width * 0.8;
    final textfieldwidth = screenwidth / 10;
    return Scaffold(
        backgroundColor: offwhite,
        appBar: AppBar(
          backgroundColor: green,
          title: const Text(
            "تسجيل الدخول",
            style: AppBartext,
          ).tr(),
        ),
        body: BlocProvider(
          create: (context) => AuthBloc(),
          child: Builder(builder: (context) {
            return Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: const Text("erter your code",
                              style: style_enter_yourcode)
                          .tr()),
                ),
                const Spacer(
                  flex: 1,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "code",
                        style: style_text_code,
                      ).tr()),
                ),
                Center(
                  child: Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // spacing: 5,
                      children: [
                        Bigotp(
                          controller: controller1,
                        ),
                        // OtpField(
                        //   controller: controller2,
                        // ),
                        // OtpField(
                        //   controller: controller3,
                        // ),
                        // OtpField(
                        //   controller: controller4,
                        // ),
                        // OtpField(
                        //   controller: controller5,
                        // ),
                        // OtpField(
                        //   controller: controller6,
                        // ),
                        // OtpField(
                        //   controller: controller7,
                        // ),
                        // OtpField(
                        //   controller: controller8,
                        // )
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                        text: "أعد ارسال الكود",
                        style: forget_pass,
                        children: [
                          const TextSpan(text: "   "),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  final Uri url = Uri(
                                    scheme: 'tel',
                                    path: '0934906018',
                                  );
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    print('Can not lunch this url');
                                  }
                                },
                              text: "اتصل بنا",
                              style: underLine_resend)
                        ]),
                  ),
                ),

                const Spacer(
                  flex: 2,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SuccessSign) {
                      // ! Replace with pushReplacemenent
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CorePage(),
                        ),
                        (route) => !(Navigator.of(context).canPop()),
                      );
                    } else if (state is WronginputException) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(" wrong enter value")));
                    } else if (state is nointernetException) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("no internet")));
                    }
                  },
                  child: InkWell(
                    onTap: () async {
                      String signincode = controller1.text;
                      

                      String devceid = await loadeviceId();
                      // ignore: use_build_context_synchronously
                      context.read<AuthBloc>().add(SignEvent(
                          user: UserRequest(
                              device_id: devceid, signIn_code: signincode)));

                      print("some thing is sender" + devceid + controller1.text
                          
                          );
                    },
                    child: InkWell(
                      child: const UseableGreenContainer(text: "تحقق"),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                )
                //  Text.rich( ),
              ],
            );
          }),
        ));
  }
}
