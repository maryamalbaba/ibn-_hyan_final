// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'scorebloc_bloc.dart';

@immutable
sealed class ResultGetExamblocState {}

final class ResultblocInitial extends ResultGetExamblocState {}

class SuccessGetResult extends ResultGetExamblocState {
   final ResultExam result;
  SuccessGetResult({
    required this.result,
  });
}

class FailedGetResult extends ResultGetExamblocState {}

class LosadingGetResult extends ResultGetExamblocState {}
