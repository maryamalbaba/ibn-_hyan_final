import 'dart:io';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnhyanfinal/core/core_page.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/resourses/styles_manager.dart';
import 'package:ibnhyanfinal/core/widgets/otp_field.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/presenture/view/subject_page.dart';
import 'package:ibnhyanfinal/feature/auth/bloc/auth_bloc.dart';
import 'package:ibnhyanfinal/feature/auth/model/usermodel.dart';

class SignPage extends StatelessWidget {
   SignPage({super.key});
  TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();
    TextEditingController controller4 = TextEditingController();
    TextEditingController controller5 = TextEditingController();
    TextEditingController controller6 = TextEditingController();
    TextEditingController controller7 = TextEditingController();
    TextEditingController controller8 = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    Future<String> getAndroidId() async {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // String andridd = androidInfo.id;
      // return andridd;// Unique ID for each Android device
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidinf = await deviceInfo.androidInfo;
        return androidinf.id;
      } else if (Platform.isWindows) {
        WindowsDeviceInfo windowsinfo = await deviceInfo.windowsInfo;
        return windowsinfo.computerName;
      } else {
        return "12345678";
      }
    }

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
                      child:
                          const Text("erter your code", style: style_enter_yourcode)
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
                        OtpField(
                          controller: controller1,
                        ),
                        OtpField(
                          controller: controller2,
                        ),
                        OtpField(
                          controller: controller3,
                        ),
                        OtpField(
                          controller: controller4,
                        ),
                        OtpField(
                          controller: controller5,
                        ),
                        OtpField(
                          controller: controller6,
                        ),
                        OtpField(
                          controller: controller7,
                        ),
                        OtpField(
                          controller: controller8,
                        )
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
                        text: "did you forget your code".tr(),
                        style: forget_pass,
                        children: [
                          const TextSpan(text: "   "),
                          TextSpan(text: "resend".tr(), style: underLine_resend)
                        ]),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SuccessSign) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("succ")));
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CorePage()));
                    } 
                     else if (state is WronginputException){
                       ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text(" wrong enter value")));
                    }
                      else if( state is nointernetException){
                         ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("no internet")));
                      }
                     else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text("error")));
                    }
                  },
                  child: InkWell(
                      onTap: () async {
                        String signincode = controller1.text +
                            controller2.text +
                            controller3.text +
                            controller4.text +
                            controller5.text +
                            controller6.text +
                            controller7.text +
                            controller8.text;

                        String devceid = await getAndroidId();
                        // ignore: use_build_context_synchronously
                        context.read<AuthBloc>().add(SignEvent(
                            user: UserRequest(
                                device_id: devceid, signIn_code: signincode)));

                        print("some thing is sender" +
                            devceid +
                            controller1.text +
                            controller2.text +
                            controller3.text +
                            controller4.text +
                            controller5.text +
                            controller6.text +
                            controller7.text +
                            controller8.text);
                      },
                      child: InkWell(
                        child: const Useable_Green_container(text: "تحققق"))),
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
