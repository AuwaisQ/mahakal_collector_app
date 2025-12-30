class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.token,
    required this.type,
  });

  final bool status;
  final String message;
  final String token;
  final String type;

  factory LoginModel.fromJson(Map<String, dynamic> json){
    return LoginModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      token: json["token"] ?? "",
      type: json["type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "type": type,
  };

}
