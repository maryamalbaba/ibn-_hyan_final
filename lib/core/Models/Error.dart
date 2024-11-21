
// ignore: file_names
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Result.dart';

class ErrorModel extends Result {

String errors;
  ErrorModel({
    required this.errors,
  });

  ErrorModel copyWith({
    String? errors,
  }) {
    return ErrorModel(
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errors': errors,
    };
  }

  factory ErrorModel.fromMap(dynamic map) {
    return ErrorModel(
      errors: map.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) => ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ErrorModel(errors: $errors)';

  @override
  bool operator ==(covariant ErrorModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.errors == errors;
  }

  @override
  int get hashCode => errors.hashCode;
}
