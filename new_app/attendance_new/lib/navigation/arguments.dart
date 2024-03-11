// Auth Module

class GeneratedQRCodeScreenArguments {
  final String link;
  GeneratedQRCodeScreenArguments({required this.link});
}

class OtpScreenArguments {
  var verificationId, resendToken, auth;

  OtpScreenArguments(
      {required this.verificationId,
      required this.resendToken,
      required this.auth});
}

class CourseDetailScreenArguments {
  final int id;
  final bool free;
  CourseDetailScreenArguments({required this.id, required this.free});
}
