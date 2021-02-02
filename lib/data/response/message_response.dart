class MessageResponse {
  final String msg;
  final bool isSuccess;

  MessageResponse({
    this.isSuccess,
    this.msg,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      isSuccess: json['isSuccess'] as bool,
      msg: json['msg'] as String,
    );
  }
}
