import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';

import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/subject_details_quiz/data/Model/Subject.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiConsumer api = DioConsumer(dio: Dio());

class SubjectDetailsQuiz {
  Future<Either<ErrorModel, List<SubjecDetailsQuizs>>>
      get_subject_detail_quizes(num id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accesstoken = pref.getString("token") ?? "";
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
        return Right(res);
      } else {
        return Left(ErrorModel(errors: "error"));
      }
    } catch (e) {
      return Left((ErrorModel(errors: "error")));
    }
  }
}