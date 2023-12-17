class ErrorResponse {
  final int statusCode;
  final String message;
  final int internalCode;

  ErrorResponse({
    required this.statusCode,
    required this.message,
    required this.internalCode,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      statusCode: json['statusCode'],
      message: json['message'],
      internalCode: json['internalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'internalCode': internalCode,
    };
  }
}
