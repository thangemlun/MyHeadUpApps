class HttpCustomException implements Exception {
  final String message;

  HttpCustomException(this.message);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }

}