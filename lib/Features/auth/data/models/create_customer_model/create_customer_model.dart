class CreateCustomerModel {
  String? id;
  String? name;
  String? email;
  dynamic phone;
  dynamic address;

  CreateCustomerModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
  });

  factory CreateCustomerModel.fromJson(Map<String, dynamic> json) {
    return CreateCustomerModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
      };
}
