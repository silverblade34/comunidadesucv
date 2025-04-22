class Comment {
  final int id;
  final String text;
  final String username;
  final String userImage;
  final DateTime timestamp;
  
  Comment({
    required this.id,
    required this.text,
    required this.username,
    required this.userImage,
    required this.timestamp,
  });
}