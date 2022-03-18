class Success {
  int? code;
  Object response;
  Success({this.code, required this.response});
}

class Failure {
  int code;
  Object errrorResponse;

  Failure({required this.code, required this.errrorResponse});
}
