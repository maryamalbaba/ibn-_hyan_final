import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';

import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/data/Model/Subject.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiConsumer api = DioConsumer(dio: Dio());

class SubjectDetailsQuiz {
  Future<Either<ErrorModel, List<SubjecDetailsQuizs>>>
      get_subject_detail_quizes(num id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accesstoken = Auth().token;
    Response response = await api.get(
        get_detail_subject_quizes_url + id.toString(),
        options: Options(headers: {"Authorization": "Bearer $accesstoken"}));
    print("student token :" + accesstoken);
    print("before try in get_detail_subject_quizes_");
    try {
      if (response.statusCode == 200) {
        print("200 in get_detail_subject_quizes_");
        List<SubjecDetailsQuizs> res = List.generate(
            response.data["data"].length,
            (index) =>
                SubjecDetailsQuizs.fromMap(response.data["data"][index]));
                print(res);
        return Right(res);
      } else {
        return Left(
          ErrorModel());
      }
    } catch (e) {
      print("error");
      print(e);
      return Left((ErrorModel()));
    }
  }
}
