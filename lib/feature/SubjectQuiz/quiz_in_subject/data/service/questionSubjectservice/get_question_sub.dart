import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/response_quiz.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiConsumer api = DioConsumer(dio: Dio());

class QuizinSubject {
  Auth auth = Auth();

  Future<Either<ErrorModel, ResponseQuizAllSubject>>
      get_response_subject_quizes(num id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Response response = await api.get(get_Quiz_Subject_Id_url + id.toString(),
        options: Options(headers: {"Authorization": "Bearer ${auth.token}"}));
    print("student token : + ${auth.token}");
    print("before try in get__subject_quizes_");
    try {
      if (response.statusCode == 200) {
        print("200 in get_detail_subject_quizes_");

print(response.data["data"]);
print("yyy");
print(response.data["data"]["separated_questions"]);
//  print( ResponseQuizAllSubject.fromMap(response.data["data"]["separated_questions"]));
        ResponseQuizAllSubject res =
            ResponseQuizAllSubject.fromMap(response.data["data"]);

        print(res.separated_questions);
        return Right(res);
      } else {
        return Left(ErrorModel());
      }
    } catch (e) {
      if (e is TypeError) {
        print(e.stackTrace);
      }
      print(e);
      return Left((ErrorModel()));
    }
  }
}
