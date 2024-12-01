import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Error/failure.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/Models/Result.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/auth/model/response_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/Error/noInternet.dart';

class Auth {
  List<user_response>userList=[];
  DioConsumer api = DioConsumer(dio: Dio());
  Future<Result> sign(user_request) async {
    try {
      Response response =
          await api.post(user_sign_url, data: user_request.toMap());
      if (response.statusCode == 200) {
        print(response.data);

        user_response res =
            user_response.fromMap(response.data["data"]["user"]);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("token", response.data["data"]["token"]);

           pref.setString("first_name", response.data["data"]["user"]["first_name"]);
            pref.setString("last_name", response.data["data"]["user"]["last_name"]);
             pref.setString("signIn_code", response.data["data"]["user"]["signIn_code"]);
 
 
        userList.add(res);
        return res;
      }
      if (response.statusCode == 401) {
        wronginputFailure res_wrong_input = wronginputFailure.fromMap(response.data["message"]);
          

        return res_wrong_input;
      } else {
        return offlineException(errors: "no internet");
      }
    } catch (e) {
      ErrorModel exception_res = ErrorModel(errors: "some thing went wrong");
      return exception_res;
    }
  }
}
