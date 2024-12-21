part of 'send_answer_bloc.dart';

@immutable
sealed class SendAnswerState {}

final class SendAnswerInitial extends SendAnswerState {}

final class SendAnswerSuccess extends SendAnswerState {
 final List<SentAnswerModel> list;

  SendAnswerSuccess(this.list);
}

final class SendAnswerfailed extends SendAnswerState {}

final class SendAnswerLoading extends SendAnswerState {}
