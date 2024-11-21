// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'subject_bloc.dart';

@immutable
sealed class SubjectDetailsEvent {}

class GetAllSubjectDetailsQuiz extends SubjectDetailsEvent {
 num id;
  GetAllSubjectDetailsQuiz({
    required this.id,
  });
}
