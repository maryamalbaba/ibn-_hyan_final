
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/data/Model/Subject.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:ibnhyanfinal/feature/statistics/data/model/statiscis_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiConsumer api = DioConsumer(dio: Dio());

class StatisticsService {
  Auth auth=Auth();
  Future<Either<ErrorModel, List<StatiscisModel>>> getsubject() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
   
    String accesstoken =auth.token;
    Response response = await api.get(statistics,
        options: Options(headers: {"Authorization": "Bearer $accesstoken"}));
    print(" student token : " + accesstoken);
    print("before try in subject");
    try {
      if (response.statusCode == 200) {
        print("200 in subject");
        List<StatiscisModel> res = List.generate(response.data["data"].length,
            (index) => StatiscisModel.fromMap(response.data["data"][index]));
            print("res is"+"$res");
            print(res.runtimeType);
        return Right(res);
      } else {
        print("else in service show sub");
        return Left(ErrorModel());
      }
    } catch (e) {
      print("error is in show sub");
      print(e);
      return Left((ErrorModel()));
    }
  }
}
