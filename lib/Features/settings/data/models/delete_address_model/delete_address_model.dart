class DeleteAddressModel{
  bool? status;
  dynamic message;

  DeleteAddressModel({this.status, this.message});

  factory DeleteAddressModel.fromJson(Map<String, dynamic> json) {
    return DeleteAddressModel(
      status: json['status'] as bool?,
      message: json['message'] as dynamic,
    );
  }
}