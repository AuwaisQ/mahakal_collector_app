class CollectorSdmListModel {
  CollectorSdmListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory CollectorSdmListModel.fromJson(Map<String, dynamic> json){
    return CollectorSdmListModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.seniorId,
    required this.seniorName,
    required this.seniorDesignation,
    required this.totalJuniorOfficers,
    required this.juniorOfficers,
  });

  final int? seniorId;
  final String? seniorName;
  final String? seniorDesignation;
  final int? totalJuniorOfficers;
  final List<SdmList> juniorOfficers;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      seniorId: json["senior_id"],
      seniorName: json["senior_name"],
      seniorDesignation: json["senior_designation"],
      totalJuniorOfficers: json["total_junior_officers"],
      juniorOfficers: json["junior_officers"] == null ? [] : List<SdmList>.from(json["junior_officers"]!.map((x) => SdmList.fromJson(x))),
    );
  }

}

class SdmList {
  SdmList({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.designation,
    required this.department,
    required this.districtId,
    required this.policeStationId,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? designation;
  final String? department;
  final int? districtId;
  final dynamic policeStationId;
  final DateTime? createdAt;

  factory SdmList.fromJson(Map<String, dynamic> json){
    return SdmList(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"],
      designation: json["designation"],
      department: json["department"],
      districtId: json["district_id"],
      policeStationId: json["police_station_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

}
