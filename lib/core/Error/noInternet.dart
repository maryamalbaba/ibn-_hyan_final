// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ibnhyanfinal/core/Models/Error.dart';

// ignore: camel_case_types
class offlineException extends ErrorModel {
  @override
  // ignore: overridden_fields
  String errors;
  offlineException({
    required this.errors,
  }) : super(errors: "no internet error");



  @override
  offlineException copyWith({
    String? errors,
  }) {
    return offlineException(
      errors: errors ?? this.errors,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errors': errors,
    };
  }

  factory offlineException.fromMap(Map<String, dynamic> map) {
    return offlineException(
      errors: map['errors'] as String,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory offlineException.fromJson(String source) => offlineException.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'offlineException(errors: $errors)';

  @override
  bool operator ==(covariant offlineException other) {
    if (identical(this, other)) return true;
  
    return 
      other.errors == errors;
  }

  @override
  int get hashCode => errors.hashCode;
}
