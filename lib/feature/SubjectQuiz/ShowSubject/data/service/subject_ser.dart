import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';

import 'package:ibnhyanfinal/core/api/api_consumer.dart';
import 'package:ibnhyanfinal/core/api/dio_consumer.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/data/Model/Subject.dart';
import 'package:ibnhyanfinal/feature/auth/service/real/sign_ser.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiConsumer api = DioConsumer(dio: Dio());

class Subject {
  Auth auth=Auth();
  Future<Either<ErrorModel, List<SubjectModel>>> getsubject() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
   
    String accesstoken =auth.token;
    Response response = await api.get(get_subject_url,
        options: Options(headers: {"Authorization": "Bearer $accesstoken"}));
    print(" student token : " + accesstoken);
    print("before try in subject");
    try {
      if (response.statusCode == 200) {
        print("200 in subject");
        List<SubjectModel> res = List.generate(response.data["data"].length,
            (index) => SubjectModel.fromMap(response.data["data"][index]));
        return Right(res);
      } else {
        return Left(ErrorModel(errors: "error"));
      }
    } catch (e) {
      return Left((ErrorModel(errors: "error")));
    }
  }
}
