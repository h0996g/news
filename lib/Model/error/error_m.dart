class ErrorModel {
  final String status;
  final String code;
  final String message;

  ErrorModel({required this.status, required this.code, required this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: json['status'] ?? '',
      code: json['code'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'code': code, 'message': message};
  }
}
