class UserModel {

  final String register;
  final String password;

  UserModel({
    required this.register,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'register': register,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      register: json['register'],
      password: json['password'],
    );
  }
}
