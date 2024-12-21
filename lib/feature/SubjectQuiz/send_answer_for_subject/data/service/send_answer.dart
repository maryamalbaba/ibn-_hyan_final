import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/Models/Result.dart';
import 'package:ibnhyanfinal/core/Models/Success.dart';
import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendAnswerServices {
  ApiConsumer api = DioConsumer(dio: Dio());
  Auth auth=Auth();
  Future<Result> send_answer_service( List <SentAnswerModel>list1) async {
     SharedPreferences pref = await SharedPreferences.getInstance();

      String accesstoken = auth.token;
      print("token issss $accesstoken");
    Response response = await api.post(sendAnswer, options: Options(headers: {"Authorization": "Bearer $accesstoken"}) ,
    data:{"solves":list1.map((item)=>item.toMap() ).toList()});
    try {
      if (response.statusCode == 200) {
        print(response.data["message"]);
        return SuccessModel();
      } else {
        print(response.statusCode);
        print(response.data["message"]);
 print("error in send answer");
        return ErrorModel();
      }
    } catch (e) {
      print(e);
      print("exception in send answer");
      print(e);
      return ErrorModel();
    }
  }
}
