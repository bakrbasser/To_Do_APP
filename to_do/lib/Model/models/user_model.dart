class UserModel {
  final int id;
  final String username;
  final String password;

  UserModel({required this.id, required this.username, required this.password});

  Map<String, dynamic> toRow() {
    return {'username': username, 'password': password};
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'password': password};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }
}
