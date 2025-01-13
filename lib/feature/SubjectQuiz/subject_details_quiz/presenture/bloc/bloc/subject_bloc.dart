import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/data/Model/Subject.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/data/service/subject_ser.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/subject_details_quiz/presenture/view/subject_details_page.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'subject_event.dart';

part 'subject_state.dart';

class SubjectdetailsBloc
    extends Bloc<SubjectDetailsEvent, SubjectdetailsQuizState> {
  SubjectdetailsBloc() : super(SubjectDetailsQuizInitial()) {
    on<GetAllSubjectDetailsQuiz>((event, emit) async {
      emit(LoadingGetSubjectDetailsQuiz());
      try {
        final endpoint = event.type == QuizPageType.subject
            ? "quizzes/subject/${event.id}"
            : event.type == QuizPageType.unit
                ? "by-subject/${event.id}/units"
                : "by-subject/${event.id}/lessons";
        Either<ErrorModel, List<SubjecDetailsQuizs>> result =
            await SubjectDetailsQuiz().get_subject_detail_quizes(endpoint);
        result.fold((error) {
          emit(ErrorGetSubjectDetailsQuiz());
        }, (quizzes) {
          emit(SuucessGetSubjectDetailsQuiz(quizzes: quizzes));
        });
      } catch (e) {
        emit(ErrorGetSubjectDetailsQuiz());
      }
    });
  }
}
