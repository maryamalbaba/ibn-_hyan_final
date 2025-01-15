import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/config/sharedpref.dart';
import 'package:ibnhyanfinal/core/core_page.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/auth/model/response_model.dart';
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
  List<String> tokens = [];
  List listtokens = [];
  List<RespoonseModel> users = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginState();
  }

  Future<void> checkLoginState() async {
    setState(() {
      final token = pref.getString("token");

      List<String> userStrings = pref.getStringList("users") ?? [];

      users = userStrings.map((e) => RespoonseModel.fromJson((e))).toList();
      isLoggedIn = users.isNotEmpty;
//!edit

      tokens = users.map((user) => user.token).toList();
      pref.setStringList("savedtokens", tokens);
    });
  }

  login(int index) {
    auth.token = users[index].token;
    pref.setString("token", auth.token);
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // if (isLoggedIn)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(logo,
                      height: MediaQuery.of(context).size.height * 0.30,
                    ),
                    const SizedBox(height: 10),
                    const Text("مرحبا بك في الشامل", style: TextStyle(fontSize: 26, color: green,  fontWeight: FontWeight.w700),),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    // pref.setStringList("savedtokens",tokens[index] );
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02,
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: const Color(0xff9FD7C6)),
                          color: const Color(0xffE9FFFB),
                        ),
                        child: InkWell(
                          onTap: () {
                            //!extract  one token

                            login(index);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CorePage(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height * 0.01),
                                // margin: EdgeInsets.all(

                                //   MediaQuery.of(context).size.height *
                                //       0.006,
                                // ),
                                child: Image.asset(
                                  greenIconUser,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      // height: MediaQuery.of(context).size.height*0.1,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        users[index].user.first_name +
                                            " " +
                                            users[index].user.last_name,
                                        // style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.06),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.height *
                                              0.09999,
                                      //  height: MediaQuery.of(context).size.height*0.1,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        users[index].user.signIn_code,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignPage(),
                    ),
                    (route) => Navigator.canPop(context),
                  );
                },
                child: const UseableGreenContainer(
                  text: "تسجيل الدخول",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
