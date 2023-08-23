class UserModel {
  String email;
  String name;
  String password;
  String uid;
  String image;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['name'],
      password: json['password'],
      name: json['email'],
      uid: json['uid'],
      image: json['image'],
    );
  }
}
