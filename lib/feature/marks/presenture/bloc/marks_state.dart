// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'marks_bloc.dart';

@immutable
sealed class MarksState {}

final class MarksInitial extends MarksState {}

class SuccessGetMarks extends MarksState {
  List<MarksModel> list;
  SuccessGetMarks({
    required this.list,
  });
}

final class FailedGetMarks extends MarksState {}

final class LoadingMarks extends MarksState {}
