// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//q id _index >page view builder+>to know when i have to go  _aswertext_ answer tarqem
class SentAnswerModel {
  num answer_id;
  num result_id;

  num? questionid;
  num? index;
  String? answer_text;
  String? answer_tarqem;
  
  SentAnswerModel({
    required this.answer_id,
    required this.result_id,
    this.questionid,
    this.index,
    this.answer_text,
    this.answer_tarqem,
  });

  SentAnswerModel copyWith({
    num? answer_id,
    num? result_id,
  }) {
    return SentAnswerModel(
      answer_id: answer_id ?? this.answer_id,
      result_id: result_id ?? this.result_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answer_id': answer_id,
      'result_id': result_id,
    };
  }

  factory SentAnswerModel.fromMap(Map<String, dynamic> map) {
    return SentAnswerModel(
      answer_id: map['answer_id'] as num,
      result_id: map['result_id'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory SentAnswerModel.fromJson(String source) =>
      SentAnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SentAnswerModel(answer_id: $answer_id, result_id: $result_id)';

  @override
  bool operator ==(covariant SentAnswerModel other) {
    if (identical(this, other)) return true;

    return other.answer_id == answer_id && other.result_id == result_id;
  }

  @override
  int get hashCode => answer_id.hashCode ^ result_id.hashCode;
}
