import 'package:bloc/bloc.dart';
import 'package:ibnhyanfinal/core/Models/Result.dart';
import 'package:ibnhyanfinal/core/Models/Success.dart';
import 'package:ibnhyanfinal/core/resourses/api_manager.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/Model/answer.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/send_answer_for_subject/data/service/send_answer.dart';
import 'package:meta/meta.dart';

part 'send_answer_event.dart';
part 'send_answer_state.dart';

class SendAnswerBloc extends Bloc<SendAnswerEvent, SendAnswerState> {
  SendAnswerBloc() : super(SendAnswerInitial()) {
    on<SendAnswer>((event, emit) async {
      // TODO: implement event handler
      emit(SendAnswerLoading());
      try {
        Result res = await SendAnswerServices().send_answer_service(event.list);

        if (res is SuccessModel) {
          print("res is SendAnswerSuccess");
          emit(SendAnswerSuccess(event.list));
        } else {
          print("SendAnswerfailed");
          emit(SendAnswerfailed());
        }
      } catch (e) {
        emit(SendAnswerfailed());
      }
    });
  }
}
