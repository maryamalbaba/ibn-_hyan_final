import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/core/Models/Result.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/data/Model/Subject.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/data/Models/result.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/domain/service/result_exam_service.dart';
import 'package:meta/meta.dart';

part 'scorebloc_event.dart';
part 'scorebloc_state.dart';

class ResultExamblocBloc extends Bloc<ResultblocEvent, ResultGetExamblocState> {
  ResultExamblocBloc() : super(ResultblocInitial()) {
    on<GetResult>((event, emit) async {
      emit(LosadingGetResult());
      try {
        Either<ErrorModel, ResultExam> res =
            await ResultExamService().getResultExam(event.result_Id);
        print("res in bloc:${res.runtimeType}");

        res.fold((error) {
          emit(FailedGetResult());
        }, (subjects) {
          emit(SuccessGetResult(result: subjects ));
        });
      } catch (e) {
        emit(FailedGetResult());
      }
    });
   
  }
}
