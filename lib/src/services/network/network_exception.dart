class NetworkException implements Exception {
  final int? statusCode;
  final String message;

  NetworkException({this.statusCode, required this.message});
}
