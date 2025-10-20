class ApiError {
  int? code;
  final String message;

  ApiError({this.code, required this.message});
  @override
  String toString() {
    return "Api Error : $message (statusCode is $code)";
  }
}
