class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final dynamic points;
  final dynamic credit;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        points: json['points'],
        credit: json['credit'],
        token: json['token'],
      );

  Map<String, dynamic> toJson({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) =>
      {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      };
}
