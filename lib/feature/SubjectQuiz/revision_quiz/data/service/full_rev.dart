import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/data/Models/full_res_revivion.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiConsumer api = DioConsumer(dio: Dio());

class QuizinSubjectRev {
  Auth auth = Auth();

  Future<Either<ErrorModel, FullResRevivion>> get_response_subject_Rev(
      num id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Response response = await api.get("results/$id/details",
        options: Options(headers: {"Authorization": "Bearer ${auth.token}"}));
    print("student token : + ${auth.token}");
    print("before try in get__subject_Rev_");
    try {
      if (response.statusCode == 200) {
        print("200 in get_detail_subject_Revs_");

        print(response.data["data"]);
        print(response.data["data"].runtimeType);
        print("yyyhk");
 print("  seprated Questions ${response.data["data"]['separated_questions']}");
        FullResRevivion res = FullResRevivion.fromMap(response.data["data"]);
        print("res is $res");

        // print(res.separated_questions);
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
