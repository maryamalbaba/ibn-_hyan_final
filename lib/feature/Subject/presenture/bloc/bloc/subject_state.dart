// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'subject_bloc.dart';

@immutable
sealed class SubjectState {}

final class SubjectInitial extends SubjectState {}

// ignore: must_be_immutable
class SuucessGetSubject extends SubjectState {
 List< SubjectModel> subjects;
  SuucessGetSubject({
    required this.subjects,
  });
}

class ErrorGetSubject extends SubjectState {}

class ExceptionGetSubject extends SubjectState {}

class LoadingGetSubject extends SubjectState {}
