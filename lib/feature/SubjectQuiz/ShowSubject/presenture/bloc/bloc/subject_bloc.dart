import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/data/Model/Subject.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/ShowSubject/data/service/subject_ser.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(SubjectInitial()) {
    on<GetAllSubject>((event, emit) async {
      emit(LoadingGetSubject());
      Either<ErrorModel, List<SubjectModel>> result =
          await Subject().getsubject();
      result.fold((error) {
        emit(ErrorGetSubject());
      }, (subjects) {
        emit(SuucessGetSubject(subjects: subjects ));
      });
    });
  }
}
