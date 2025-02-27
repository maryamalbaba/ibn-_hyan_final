part of 'subject_question_bloc.dart';

@immutable
sealed class SubjectQuestionState {}

final class SubjectQuestionInitial extends SubjectQuestionState {}

// ignore: must_be_immutable
class SubjectQuestionSuccess extends SubjectQuestionState {
  ResponseQuizAllSubject question_with_answer;

  
  ValueNotifier<ProblemModel?> pinnedProblem = ValueNotifier<ProblemModel?>(null);

  SubjectQuestionSuccess({required this.question_with_answer});
}

final class SubjectQuestionError extends SubjectQuestionState {}

final class SubjectQuestionLoading extends SubjectQuestionState {}

final class SubjectQuestionException extends SubjectQuestionState {}
