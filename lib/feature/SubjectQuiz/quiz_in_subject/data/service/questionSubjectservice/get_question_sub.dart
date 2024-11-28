import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/question_model.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/response_quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiConsumer api = DioConsumer(dio: Dio());

class QuizinSubject {
  Future<Either<ErrorModel, List<QuestionModel>>>
      // ignore: non_constant_identifier_names
      get_subject_quizes(num id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accesstoken = pref.getString("token") ?? "";
    Response response = await api.get(get_Quiz_Subject_Id_url + id.toString(),
        options: Options(headers: {"Authorization": "Bearer $accesstoken"}));
    print("student token :" + accesstoken);
    print("before try in get__subject_quizes_");
    try {
      if (response.statusCode == 200) {
        print("200 in get_detail_subject_quizes_");
        List<QuestionModel> res = List.generate(
            response.data["data"]["separated_questions"].length,
            (index) => QuestionModel.fromMap(
                response.data["data"]["separated_questions"][index]));
        return Right(res);
      } else {
        return Left(ErrorModel(errors: "error"));
      }
    } catch (e) {
      return Left((ErrorModel(errors: "error")));
    }
  }

  Future<Either<ErrorModel, ResponseQuizAllSubject>>
      // ignore: non_constant_identifier_names
      get_response_subject_quizes(num id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accesstoken = pref.getString("token") ?? "";
    Response response = await api.get(get_Quiz_Subject_Id_url + id.toString(),
        options: Options(headers: {"Authorization": "Bearer $accesstoken"}));
    print("student token :" + accesstoken);
    print("before try in get__subject_quizes_");
    try {
      if (response.statusCode == 200) {
        print("200 in get_detail_subject_quizes_");
        
           // print(response.data["data"]);
        ResponseQuizAllSubject res =  ResponseQuizAllSubject.fromMap(response.data["data"]);
          
            print(res);
        return Right(res);
      } else {
        return Left(ErrorModel(errors: "error"));
      }
    } catch (e) {
      if(e is TypeError){
        print(e.stackTrace);
      }
      print(e);
      return Left((ErrorModel(errors: "error")));
    }
  }
}
