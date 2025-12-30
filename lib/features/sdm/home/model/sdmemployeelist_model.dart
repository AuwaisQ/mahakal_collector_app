class SdmEmployeeListModel {
  SdmEmployeeListModel({
    required this.status,
    required this.message,
    required this.sdmId,
    required this.totalEmployee,
    required this.employeeList,
  });

  final bool status;
  final String message;
  final int sdmId;
  final int totalEmployee;
  final List<EmployeeList> employeeList;

  factory SdmEmployeeListModel.fromJson(Map<String, dynamic> json){
    return SdmEmployeeListModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      sdmId: json["sdm_id"] ?? 0,
      totalEmployee: json["total_employee"] ?? 0,
      employeeList: json["employee_list"] == null ? [] : List<EmployeeList>.from(json["employee_list"]!.map((x) => EmployeeList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "sdm_id": sdmId,
    "total_employee": totalEmployee,
    "employee_list": employeeList.map((x) => x?.toJson()).toList(),
  };

}

class EmployeeList {
  EmployeeList({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.district,
    required this.temples,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String email;
  final String mobile;
  final dynamic district;
  final String temples;
  final DateTime? createdAt;

  factory EmployeeList.fromJson(Map<String, dynamic> json){
    return EmployeeList(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      district: json["district"],
      temples: json["temples"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "district": district,
    "temples": temples,
    "created_at": createdAt?.toIso8601String(),
  };

}
