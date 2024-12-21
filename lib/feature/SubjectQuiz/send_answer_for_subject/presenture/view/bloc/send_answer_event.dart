part of 'send_answer_bloc.dart';

@immutable
sealed class SendAnswerEvent {}

class SendAnswer extends SendAnswerEvent {
  final List<SentAnswerModel>list;

  SendAnswer(this.list);
}
