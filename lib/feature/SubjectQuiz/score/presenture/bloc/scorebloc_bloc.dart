import 'package:bloc/bloc.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/score/data/Models/result.dart';
import 'package:meta/meta.dart';

part 'scorebloc_event.dart';
part 'scorebloc_state.dart';

class ResultExamblocBloc extends Bloc<ResultblocEvent, ResultGetExamblocState> {
  ResultExamblocBloc() : super(ResultblocInitial()) {
    on<ResultblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
