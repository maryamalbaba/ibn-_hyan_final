// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'scorebloc_bloc.dart';

@immutable
sealed class ResultblocEvent {

}
class GetResult extends ResultblocEvent {

   final num result_Id;
  GetResult({
    required this.result_Id,
  });
}
