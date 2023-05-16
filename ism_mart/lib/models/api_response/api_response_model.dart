import 'dart:convert';

class ApiResponse {
  ApiResponse(
      {this.success,
      this.key,
      this.message,
      this.error,
      this.data,
      this.errors});

  bool? success, key;
  String? message, error;
  dynamic data;
  List<String>? errors;

  Map<String, dynamic> toJson() => {
        'success': success,
        'key': key,
        'message': message,
        'error': error,
        'errors': jsonEncode(errors),
        'data': data?.toJson()
      };

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        success: json['success'] == null ? false : json['success'],
        message: json['message'] ?? "",
        data: json['data'] == null ? null : json['data']);
  }

  // factory ApiResponse.fromJson(Map<String, dynamic> json) {
  //   return ApiResponse(
  //       success: json['success'] == null ? false : json['success'],
  //       key: json['key'] ?? '',
  //       message: json['message'] ?? "",
  //       error: json['error'] == null ? "" : json['error'],
  //       errors: json['errors'] != null
  //           ? List<String>.from(json["errors"].map((x) => x))
  //           : null,
  //       data: json['data'] == null ? null : json['data']);
  // }
}
