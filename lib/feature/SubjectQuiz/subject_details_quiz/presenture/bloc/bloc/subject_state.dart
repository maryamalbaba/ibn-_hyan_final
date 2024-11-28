// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'subject_bloc.dart';

@immutable
sealed class SubjectdetailsQuizState {}

final class SubjectDetailsQuizInitial extends SubjectdetailsQuizState {}

class SuucessGetSubjectDetailsQuiz extends SubjectdetailsQuizState {
 List< SubjecDetailsQuizs> subjects;
  SuucessGetSubjectDetailsQuiz({
    required this.subjects,
  });
}

class ErrorGetSubjectDetailsQuiz extends SubjectdetailsQuizState {}

class ExceptionGetSubjectDetailsQuiz extends SubjectdetailsQuizState {}

class LoadingGetSubjectDetailsQuiz extends SubjectdetailsQuizState {}
