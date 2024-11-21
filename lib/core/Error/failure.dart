// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Error.dart';

class serverfailur extends ErrorModel {
  serverfailur({required super.errors});
}



// ignore: camel_case_types
class cacheFailure extends ErrorModel {
  cacheFailure({required super.errors});
}

class wronginputFailure extends ErrorModel {
  String errors;
  wronginputFailure({
    required this.errors,
  }) : super(errors: 'wrong input');

  @override
  wronginputFailure copyWith({
    String? errors,
  }) {
    return wronginputFailure(
      errors: errors ?? this.errors,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errors': errors,
    };
  }

  factory wronginputFailure.fromMap(Map<String, dynamic> map) {
    return wronginputFailure(
      errors: map['errors'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory wronginputFailure.fromJson(String source) => wronginputFailure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'wrongEnterFailure(errors: $errors)';

  @override
  bool operator ==(covariant wronginputFailure other) {
    if (identical(this, other)) return true;
  
    return 
      other.errors == errors;
  }

  @override
  int get hashCode => errors.hashCode;
}
