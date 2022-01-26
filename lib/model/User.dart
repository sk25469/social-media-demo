class UserModel {
  String name, email;

  UserModel({
    required this.email,
    required this.name,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
