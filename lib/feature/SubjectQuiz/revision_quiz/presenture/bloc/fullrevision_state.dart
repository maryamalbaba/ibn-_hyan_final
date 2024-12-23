part of 'fullrevision_bloc.dart';

@immutable
sealed class FullrevisionState {}

final class FullrevisionInitial extends FullrevisionState {}

final class SubjectRevInitial extends FullrevisionState {}

// ignore: must_be_immutable
final class SubjectRevSuccess extends FullrevisionState {
  FullResRevivion question_with_answer;

  SubjectRevSuccess({required this.question_with_answer});
}

final class SubjectRevError extends FullrevisionState {}

final class SubjectRevLoading extends FullrevisionState {}

final class SubjectRevException extends FullrevisionState {}
