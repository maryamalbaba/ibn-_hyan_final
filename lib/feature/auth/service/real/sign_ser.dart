import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Error/failure.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/Models/Result.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/auth/model/response_model.dart';
import 'package:ibnhyanfinal/feature/auth/model/response_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Error/noInternet.dart';
import '../../model/usermodel.dart';

class Auth {
  List<String> userList = [];
  DioConsumer api = DioConsumer(dio: Dio());

  String token = "";
  Auth.internal(
    
  );

  static final Auth _instance = Auth.internal();
  
  factory Auth() {
    return _instance;
  }
  Future<Result> sign(UserRequest user_request) async {
    try {
      Response response =
          await api.post(user_sign_url, data: user_request.toMap());
      if (response.statusCode == 200) {
        print(response.data);

        RespoonseModel res = RespoonseModel.fromMap(response.data["data"]);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("token", response.data["data"]["token"]);
        token = pref.getString("token") ?? "";

        userList = pref.getStringList("users") ?? [];
        final users = userList.map((e) => RespoonseModel.fromJson((e))).toList();
        final existsIndex = users.indexWhere((element) => element.user.signIn_code == user_request.signIn_code);
        if(existsIndex != -1){
          userList[existsIndex] = res.toJson();
        }else{
          userList.add(res.toJson());
          pref.setStringList("users", userList);
        }
        print("the updated  old list" + userList.toString());

        return res;
      }
      if (response.statusCode == 401) {
        wronginputFailure res_wrong_input =
            wronginputFailure.fromMap(response.data["message"]);

        return res_wrong_input;
      } else {
        return offlineException(errors: "no internet");
      }
    } catch (e) {
  //    ErrorModel exception_res = ErrorModel(errors: "some thing went wrong");
      return ErrorModel();
    }
  }
}
