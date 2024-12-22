import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/model/response_quiz.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/quiz_in_subject/data/service/questionSubjectservice/get_question_sub.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'subject_question_event.dart';
part 'subject_question_state.dart';

class SubjectQuestionBloc
    extends Bloc<SubjectQuestionEvent, SubjectQuestionState> {
  SubjectQuestionBloc() : super(SubjectQuestionInitial()) {
    on<GetSubjectQuestionEvent>((event, emit) async {
      emit(SubjectQuestionLoading());
      Either<ErrorModel, ResponseQuizAllSubject> result =
          await QuizinSubject().get_response_subject_quizes(event.id);
      result.fold((erorr) {
        emit(SubjectQuestionError());
      }, (AllQuize) {
        emit(SubjectQuestionSuccess(question_with_answer: AllQuize));
      });
    });
  }
}