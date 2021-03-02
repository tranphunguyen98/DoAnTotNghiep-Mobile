class MessageResponseRegister {
  final String message;
  final bool succeeded;

  MessageResponseRegister({this.succeeded, this.message});

  factory MessageResponseRegister.fromJson(Map<String, dynamic> json) {
    return MessageResponseRegister(
      succeeded: json['succeeded'] as bool,
      message: json['message'] as String,
    );
  }
}
