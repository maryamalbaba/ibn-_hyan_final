import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/data/Models/full_res_revivion.dart';
import 'package:ibnhyanfinal/feature/SubjectQuiz/revision_quiz/data/service/full_rev.dart';
import 'package:meta/meta.dart';

part 'fullrevision_event.dart';
part 'fullrevision_state.dart';

class FullrevisionBloc extends Bloc<FullrevisionEvent, FullrevisionState> {
  FullrevisionBloc() : super(FullrevisionInitial()) {
    
      // TODO: implement event handler
      on<GetSubjecRevEvent>((event, emit) async {
     try{ emit(SubjectRevLoading());
      Either<ErrorModel, FullResRevivion> result =
          await QuizinSubjectRev().get_response_subject_Rev(event.id);
      result.fold((erorr) {
        emit(SubjectRevError());
      }, (AllQuize) {
        emit(SubjectRevSuccess(question_with_answer: AllQuize));
      });}
     catch(e){
      emit( SubjectRevError());

     }
    });
   
  }
}
