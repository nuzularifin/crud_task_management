class LoginResponseModel {
  String? token;

  LoginResponseModel({required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
