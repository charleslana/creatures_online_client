import 'dart:convert';

class ResponseModel {
  ResponseModel({
    required this.error,
    required this.message,
    this.validation,
  });

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    if (map['error'] == 'Bad Request') {
      map['error'] = true;
    }
    return ResponseModel(
      error: map['error'] as bool,
      message: map['message'] as String,
      validation: map['validation'] != null
          ? Validation.fromMap(map['validation'] as Map<String, dynamic>)
          : null,
    );
  }

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  dynamic error;
  String message;
  Validation? validation;

  ResponseModel copyWith({
    bool? error,
    String? message,
    Validation? validation,
  }) {
    return ResponseModel(
      error: error ?? this.error,
      message: message ?? this.message,
      validation: validation ?? this.validation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'message': message,
      'validation': validation?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class Validation {
  Validation({
    required this.body,
  });

  factory Validation.fromMap(Map<String, dynamic> map) {
    return Validation(
      body: Body.fromMap(map['body'] as Map<String, dynamic>),
    );
  }

  factory Validation.fromJson(String source) =>
      Validation.fromMap(json.decode(source) as Map<String, dynamic>);

  Body body;

  Validation copyWith({
    Body? body,
  }) {
    return Validation(
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class Body {
  Body({
    required this.source,
    required this.keys,
    required this.message,
  });

  factory Body.fromMap(Map<String, dynamic> map) {
    return Body(
      source: map['source'] as String,
      keys: List<dynamic>.from(map['keys'] as List<dynamic>),
      message: map['message'] as String,
    );
  }

  factory Body.fromJson(String source) =>
      Body.fromMap(json.decode(source) as Map<String, dynamic>);
  String source;
  List<dynamic> keys;
  String message;

  Body copyWith({
    String? source,
    List<String>? keys,
    String? message,
  }) {
    return Body(
      source: source ?? this.source,
      keys: keys ?? this.keys,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source,
      'keys': keys,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());
}
