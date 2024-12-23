part of 'fullrevision_bloc.dart';

@immutable
sealed class FullrevisionEvent {


}
class GetSubjecRevEvent extends FullrevisionEvent {
  num id;
  GetSubjecRevEvent({
    required this.id,
  });}