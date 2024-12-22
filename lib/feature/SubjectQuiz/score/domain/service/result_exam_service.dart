import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/data/Models/result.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';

class ResultExamService {
  Future<Either<ErrorModel, ResultExam>> getResultExam(num result_Id) async {
    try {
      Auth auth = Auth();
      ApiConsumer api = DioConsumer(dio: Dio());
      String accesstoken = auth.token;

      Response response = await api.get("results/$result_Id/details",
          options: Options(headers: {"Authorization": "Bearer $accesstoken"}));
      if (response.statusCode == 200) {
        ResultExam result = ResultExam.fromMap(response.data["data"]);
        return Right(result);
      } else {
        return Left(ErrorModel());
      }
    } catch (e) {
      return Left(ErrorModel());
    }
  }
}
