import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ibnhyanfinal/core/Models/Error.dart';
import 'package:ibnhyanfinal/feature/marks/data/Models/marks.dart';
import 'package:ibnhyanfinal/feature/marks/data/services/marks.dart';
import 'package:meta/meta.dart';

part 'marks_event.dart';
part 'marks_state.dart';

class MarksBloc extends Bloc<MarksEvent, MarksState> {
  MarksBloc() : super(MarksInitial()) {
    on<GetmarksEvent>((event, emit) async {
      // TODO: implement event handler
      emit(LoadingMarks());
      Either<ErrorModel, List<MarksModel>> result =
          await MarksService().getMarks();
      result.fold((error) {
        emit(FailedGetMarks());
      }, (markslist) {
        emit(SuccessGetMarks(list: markslist));
      });
    });
  }
}
