class CollectorDashModel {
  CollectorDashModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory CollectorDashModel.fromJson(Map<String, dynamic> json){
    return CollectorDashModel(
      status: json["status"],
      message: json["message"],
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
    required this.designation,
    required this.department,
    required this.reportingTo,
    required this.districtId,
    required this.policeStationId,
    required this.status,
    required this.totalTemple,
    required this.totalUser,
    required this.totalAmount,
    required this.temples,
  });

  final int? id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? designation;
  final String? department;
  final dynamic reportingTo;
  final int? districtId;
  final dynamic policeStationId;
  final int? status;
  final int? totalTemple;
  final int? totalUser;
  final int? totalAmount;
  final List<TemplesDetail> temples;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      name: json["name"],
      mobile: json["mobile"],
      email: json["email"],
      designation: json["designation"],
      department: json["department"],
      reportingTo: json["reporting_to"],
      districtId: json["district_id"],
      policeStationId: json["police_station_id"],
      status: json["status"],
      totalTemple: json["total_temple"],
      totalUser: json["total_user"],
      totalAmount: json["total_amount"],
      temples: json["temples"] == null ? [] : List<TemplesDetail>.from(json["temples"]!.map((x) => TemplesDetail.fromJson(x))),
    );
  }

}

class TemplesDetail {
  TemplesDetail({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.state,
    required this.city,
    required this.thumbnail,
    required this.openingTime,
    required this.closeingTime,
    required this.status,
  });

  final int? id;
  final String? name;
  final String? shortDescription;
  final String? state;
  final String? city;
  final String? thumbnail;
  final String? openingTime;
  final String? closeingTime;
  final int? status;

  factory TemplesDetail.fromJson(Map<String, dynamic> json){
    return TemplesDetail(
      id: json["id"],
      name: json["name"],
      shortDescription: json["short_description"],
      state: json["state"],
      city: json["city"],
      thumbnail: json["thumbnail"],
      openingTime: json["opening_time"],
      closeingTime: json["closeing_time"],
      status: json["status"],
    );
  }

}
