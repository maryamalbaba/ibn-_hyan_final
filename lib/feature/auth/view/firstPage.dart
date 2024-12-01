import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/config/sharedpref.dart';
import 'package:ibnhyanfinal/core/core_page.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/presenture/view/subject_page.dart';
import 'package:ibnhyanfinal/feature/auth/model/response_user.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:ibnhyanfinal/feature/auth/view/sign_page.dart';

// ignore: camel_case_types

class welcomePage extends StatefulWidget {
  welcomePage({super.key});

  @override
  State<welcomePage> createState() => _welcomePageState();
}

// ignore: camel_case_types
class _welcomePageState extends State<welcomePage> {
  Auth auth = Auth();

  bool isLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginState();
  }

  Future<void> checkLoginState() async {
    setState(() {
      final token = pref.getString("token");
      print("token saved is " + token.toString());
      print("userlist is :" + auth.userList.toString());
      isLoggedIn = token != null;
      auth.userList = [
        user_response(
          first_name: pref.getString("first_name")!,
          last_name: pref.getString("last_name")!,
          signIn_code: pref.getString("signIn_code")!,
        )
      ];
      print(isLoggedIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: offwhite,
              image: DecorationImage(
                  image: AssetImage(background), fit: BoxFit.fill),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!isLoggedIn)
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            print("fffffff");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignPage()));
                          },
                          child: const Useable_Green_container(
                            text: "تسجيل الدخول",
                          ))),
                if (isLoggedIn)
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: auth.userList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.1,
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Color(0xff9FD7C6)),
                                  color: Color(0xffE9FFFB),
                                ),
                                width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: InkWell(
                                  onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CorePage()));
                              },
                                  child: ListTile(
                                      leading: Image.asset(greenIconUser),
                                      title: Text(
                                        auth.userList[index].first_name +
                                            " " +
                                            auth.userList[index].last_name,
                                      ),
                                      subtitle: Text(
                                          auth.userList[index].signIn_code)),
                                )),
                          );
                        }),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        print("fffffff");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignPage()));
                      },
                      child: const Useable_Green_container(
                        text: "تسجيل الدخول",
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
