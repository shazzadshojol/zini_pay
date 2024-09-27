class UserModel {
  String? email;
  String? apiKey;

  UserModel({this.email, this.apiKey});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    apiKey = json['apiKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['apiKey'] = apiKey;
    return data;
  }
}
