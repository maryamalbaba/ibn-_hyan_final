import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:ibnhyanfinal/feature/marks/data/Models/marks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarksService {
  ApiConsumer api = DioConsumer(dio: Dio());
  Future<Either<ErrorModel, List<MarksModel>>> getMarks() async {
    Auth auth = Auth();
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String accesstoken = auth.token;
      print("token issss $accesstoken");
      Response response = await api.get(marks,
          options: Options(headers: {"Authorization": "Bearer $accesstoken"}));

      if (response.statusCode == 200) {
        List<MarksModel> res = List.generate(response.data["data"].length,
            (index) => MarksModel.fromMap(response.data["data"][index]));
           print("marks are");
            print(res);
        return Right( res);
      } else {
        return Left(ErrorModel());
      }
    } catch (e) {
      print("exception is");
      print(e);
      return Left(ErrorModel());
    }
  }
}
