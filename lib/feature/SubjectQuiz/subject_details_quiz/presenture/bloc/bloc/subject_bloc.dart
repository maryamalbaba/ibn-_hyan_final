import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/data/Model/Subject.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/data/service/subject_ser.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectdetailsBloc extends Bloc<SubjectDetailsEvent, SubjectdetailsQuizState> {
  SubjectdetailsBloc() : super(SubjectDetailsQuizInitial()) {
    on<GetAllSubjectDetailsQuiz>((event, emit) async {
      emit(LoadingGetSubjectDetailsQuiz());
      Either<ErrorModel, List<SubjecDetailsQuizs>> result =
          await SubjectDetailsQuiz().get_subject_detail_quizes(event.id);
      result.fold((error) {
        emit(ErrorGetSubjectDetailsQuiz());
      }, (subjects) {
        emit(SuucessGetSubjectDetailsQuiz(subjects: subjects ));
      });
    });
  }
}
