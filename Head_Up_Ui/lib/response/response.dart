import 'package:json_annotation/json_annotation.dart';

class Response {
  final bool success;
  final String message;
	late dynamic data;

  Response(this.success, this.message, {this.data});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response (
      json['success'],
      json['message'],
      data: json['data'],
    );
  }
}