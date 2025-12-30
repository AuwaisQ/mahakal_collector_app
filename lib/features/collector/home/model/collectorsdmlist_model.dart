class CollectorSdmListModel {
  CollectorSdmListModel({
    required this.status,
    required this.message,
    required this.collectorId,
    required this.totalSdm,
    required this.sdmList,
  });

  final bool status;
  final String message;
  final int collectorId;
  final int totalSdm;
  final List<SdmList> sdmList;

  factory CollectorSdmListModel.fromJson(Map<String, dynamic> json){
    return CollectorSdmListModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      collectorId: json["collector_id"] ?? 0,
      totalSdm: json["total_sdm"] ?? 0,
      sdmList: json["sdm_list"] == null ? [] : List<SdmList>.from(json["sdm_list"]!.map((x) => SdmList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "collector_id": collectorId,
    "total_sdm": totalSdm,
    "sdm_list": sdmList.map((x) => x?.toJson()).toList(),
  };

}

class SdmList {
  SdmList({
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

  factory SdmList.fromJson(Map<String, dynamic> json){
    return SdmList(
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
