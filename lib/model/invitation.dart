class Invitation {
  final String senderId;
  final String receiverId;
  final String message;

  Invitation({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  // convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
    };
  }
}
