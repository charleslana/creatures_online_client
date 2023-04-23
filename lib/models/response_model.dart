class ResponseModel {
  ResponseModel({
    required this.error,
    required this.message,
  });

  bool error;
  String message;

  Map<String, dynamic> toJson() {
    return {
      "error": error,
      "message": message,
    };
  }

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      error: json["error"],
      message: json["message"],
    );
  }
}
