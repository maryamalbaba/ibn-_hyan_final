// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'subject_question_bloc.dart';

@immutable
sealed class SubjectQuestionEvent {}

// ignore: must_be_immutable
class GetSubjectQuestionEvent extends SubjectQuestionEvent {
  num id;
  GetSubjectQuestionEvent({
    required this.id,
  });
}
