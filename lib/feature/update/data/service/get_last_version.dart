
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/core/resourses/colors_manager.dart';
import 'package:ibnhyanfinal/core/resourses/general_functions.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:ibnhyanfinal/feature/update/data/models/version.dart';
import 'package:url_launcher/url_launcher.dart';

Future<Either<ErrorModel, Version>> updateversion_service() async {
  ApiConsumer api = DioConsumer(dio: Dio());
  Auth auth = Auth();
  String accessToken = auth.token;

  try {
    Response response = await api.get(update_url,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}));

    print("hi before 200");
    if (response.statusCode == 200) {
      print("alooo");
      Version res = Version.fromMap(response.data["data"]);
      print("res is :_:");
      print(res);
      return Right(res);
    } else {
      print("else in response");
      return Left(ErrorModel());
    }
  } catch (e) {
    print("exception is :" + e.toString());
    print("catch ");

    return Left(ErrorModel());
  }
}

void checkUpdate(BuildContext context) async {
  Version v = Version(version_num: "", version_url: "");
  String currentversion = await getLocalversion();
  Either<ErrorModel, Version> upddate = await updateversion_service();
  upddate.fold((error) {
    print("failed");
  }, (lastversion) {
    if (lastversion.version_num != currentversion) {
      showDialogUpdate(context: context, url: lastversion.version_url);
    } else {
      print("Current version: $currentversion");
      print("the same version");
    }
  });
}

void showDialogUpdate({required BuildContext context, required String url}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double dialogWidth = constraints.maxWidth * 0.9;
            double dialogHeight = constraints.maxHeight * 0.4;

            return SingleChildScrollView(
              child: AlertDialog(
                title: Center(
                  child: Text("🎉 مفاجأة ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis),
                ),
                content: Container(
                  // width: dialogWidth,
                  constraints: BoxConstraints(
                    maxHeight: dialogHeight, //
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(" تحديث جديد ✨ \n حدثي التطبيق  فضلاً",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                _launchURL(url);
                              },
                              child: Text("تحديث",
                                  style: TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "إلغاء",
                                style: TextStyle(color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}