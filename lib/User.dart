class User {
  final int userId;
  final int id;
  final String title;
  final String body;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        title = json['title'],
        body = json['body'].toString().substring(0, 7);
}
