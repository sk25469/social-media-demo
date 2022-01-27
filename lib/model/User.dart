class UserModel {
  String name, email, userId;

  UserModel({
    required this.email,
    required this.name,
    required this.userId,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        userId = json['userId'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'userId': userId,
      };
}
