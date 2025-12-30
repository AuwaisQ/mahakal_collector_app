class SdmAmountFilterModel {
  SdmAmountFilterModel({
    required this.status,
    required this.message,
    required this.sdmDetail,
  });

  final bool status;
  final String message;
  final SdmDetail? sdmDetail;

  factory SdmAmountFilterModel.fromJson(Map<String, dynamic> json){
    return SdmAmountFilterModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      sdmDetail: json["sdm_detail"] == null ? null : SdmDetail.fromJson(json["sdm_detail"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "sdm_detail": sdmDetail?.toJson(),
  };

}

class SdmDetail {
  SdmDetail({
    required this.id,
    required this.name,
    required this.type,
    required this.relCollectorId,
    required this.relSdmId,
    required this.district,
    required this.email,
    required this.mobile,
    required this.password,
    required this.temples,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.cashAmount,
    required this.onlineAmount,
    required this.totalAmount,
  });

  final int id;
  final String name;
  final String type;
  final dynamic relCollectorId;
  final dynamic relSdmId;
  final int district;
  final String email;
  final String mobile;
  final String password;
  final String temples;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int cashAmount;
  final int onlineAmount;
  final int totalAmount;

  factory SdmDetail.fromJson(Map<String, dynamic> json){
    return SdmDetail(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      relCollectorId: json["rel_collector_id"],
      relSdmId: json["rel_sdm_id"],
      district: json["district"] ?? 0,
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      password: json["password"] ?? "",
      temples: json["temples"] ?? "",
      status: json["status"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      cashAmount: json["cash_amount"] ?? 0,
      onlineAmount: json["online_amount"] ?? 0,
      totalAmount: json["total_amount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "rel_collector_id": relCollectorId,
    "rel_sdm_id": relSdmId,
    "district": district,
    "email": email,
    "mobile": mobile,
    "password": password,
    "temples": temples,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "cash_amount": cashAmount,
    "online_amount": onlineAmount,
    "total_amount": totalAmount,
  };

}
