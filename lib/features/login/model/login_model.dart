// class LoginModel {
//   LoginModel({
//     required this.status,
//     required this.message,
//     required this.token,
//     required this.type,
//   });
//
//   final bool status;
//   final String message;
//   final String token;
//   final String type;
//
//   factory LoginModel.fromJson(Map<String, dynamic> json){
//     return LoginModel(
//       status: json["status"] ?? false,
//       message: json["message"] ?? "",
//       token: json["token"] ?? "",
//       type: json["type"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "token": token,
//     "type": type,
//   };
//
// }

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.token,
    required this.data,
  });

  final bool? status;
  final String? message;
  final String? token;
  final Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json){
    return LoginModel(
      status: json["status"],
      message: json["message"],
      token: json["token"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.type,
    required this.department,
    required this.reportingTo,
    required this.districtId,
    required this.policeStationId,
  });

  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? type;
  final String? department;
  final dynamic reportingTo;
  final int? districtId;
  final dynamic policeStationId;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      name: json["name"],
      mobile: json["mobile"],
      email: json["email"],
      type: json["type"],
      department: json["department"],
      reportingTo: json["reporting_to"],
      districtId: json["district_id"],
      policeStationId: json["police_station_id"],
    );
  }

}
