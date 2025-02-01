import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/config/sharedpref.dart';
import 'package:ibnhyanfinal/core/core_page.dart';
import 'package:ibnhyanfinal/core/resourses/assets_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/widgets/confirm_dialog.dart';
import 'package:ibnhyanfinal/core/widgets/useable_green_container.dart';
import 'package:ibnhyanfinal/feature/auth/model/response_model.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:ibnhyanfinal/feature/auth/view/sign_page.dart';
import 'package:ibnhyanfinal/feature/update/data/service/get_last_version.dart';

// ignore: camel_case_types

class welcomePage extends StatefulWidget {
  welcomePage({super.key});

  @override
  State<welcomePage> createState() => _welcomePageState();
}

// ignore: camel_case_types
class _welcomePageState extends State<welcomePage>
    with SingleTickerProviderStateMixin {
  Auth auth = Auth();
  bool _showText = false;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  bool isLoggedIn = false;
  List<String> tokens = [];
  List listtokens = [];
  List<RespoonseModel> users = [];

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
   
    checkLoginState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    
    _animation = Tween<Offset>(
      begin: Offset(1.0, 0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the animation
    _controller.forward();

    Timer(Duration(seconds: 1), () {
      setState(() {
        _showText = true;
      });
    });
  }

  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
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

  removeUser(int index) async {
    final strings = pref.getStringList("users") ?? [];
    strings.removeAt(index);
    final res = await pref.setStringList("users", strings);
    users = strings.map((e) => RespoonseModel.fromJson((e))).toList();
    setState(() {});
  }

  login(int index) {
    auth.token = users[index].token;
    pref.setString("token", auth.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: offwhite,
          image: DecorationImage(
              image: AssetImage(background), fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // if (isLoggedIn)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.s,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 3,
                      child: Image.asset(
                        logo,
                        // height: MediaQuery.of(context).size.height * 0.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                        child: _showText
                            ? SlideTransition(
                                position: _animation,
                                child: const FittedBox(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      "أهلاً بك في الشامل !",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "motlaq",
                                        shadows: [
                                          BoxShadow(
                                            color: Color(0x40000000),
                                            blurRadius: 12,
                                            spreadRadius: 0,
                                            offset: Offset(0, 4),
                                          )
                                        ],
                                        fontSize: 28,
                                        height: 2,
                                        color: darkerrgreen,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container()),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
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
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) => ConfirmDialog(
                                      title: "من إزالة الحساب",
                                      onConfirm: () async {
                                        removeUser(index);
                                      },
                                    ));
                          },
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
                                              0.3,
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
