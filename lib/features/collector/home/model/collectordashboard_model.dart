// class CollectorDashModel {
//   CollectorDashModel({
//     required this.status,
//     required this.message,
//     required this.sdmDetail,
//   });
//
//   final bool status;
//   final String message;
//   final SdmDetail? sdmDetail;
//
//   factory CollectorDashModel.fromJson(Map<String, dynamic> json){
//     return CollectorDashModel(
//       status: json["status"] ?? false,
//       message: json["message"] ?? "",
//       sdmDetail: json["sdm_detail"] == null ? null : SdmDetail.fromJson(json["sdm_detail"]),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "sdm_detail": sdmDetail?.toJson(),
//   };
//
// }
//
// class SdmDetail {
//   SdmDetail({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.relCollectorId,
//     required this.relSdmId,
//     required this.district,
//     required this.email,
//     required this.mobile,
//     required this.password,
//     required this.temples,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.templesDetail,
//   });
//
//   final int id;
//   final String name;
//   final String type;
//   final dynamic relCollectorId;
//   final dynamic relSdmId;
//   final int district;
//   final String email;
//   final String mobile;
//   final String password;
//   final String temples;
//   final int status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final List<TemplesDetail> templesDetail;
//
//   factory SdmDetail.fromJson(Map<String, dynamic> json){
//     return SdmDetail(
//       id: json["id"] ?? 0,
//       name: json["name"] ?? "",
//       type: json["type"] ?? "",
//       relCollectorId: json["rel_collector_id"],
//       relSdmId: json["rel_sdm_id"],
//       district: json["district"] ?? 0,
//       email: json["email"] ?? "",
//       mobile: json["mobile"] ?? "",
//       password: json["password"] ?? "",
//       temples: json["temples"] ?? "",
//       status: json["status"] ?? 0,
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//       templesDetail: json["temples_detail"] == null ? [] : List<TemplesDetail>.from(json["temples_detail"]!.map((x) => TemplesDetail.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "type": type,
//     "rel_collector_id": relCollectorId,
//     "rel_sdm_id": relSdmId,
//     "district": district,
//     "email": email,
//     "mobile": mobile,
//     "password": password,
//     "temples": temples,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "temples_detail": templesDetail.map((x) => x?.toJson()).toList(),
//   };
//
// }
//
// class TemplesDetail {
//   TemplesDetail({
//     required this.id,
//     required this.name,
//     required this.stateId,
//     required this.cityId,
//     required this.thumbnail,
//     required this.openingTime,
//     required this.closeingTime,
//     required this.employee,
//     //required this.states,
//     //required this.cities,
//     required this.translations,
//   });
//
//   final int id;
//   final String name;
//   final String stateId;
//   final String cityId;
//   final String thumbnail;
//   final String openingTime;
//   final String closeingTime;
//   final dynamic employee;
//   //final States? states;
//   //final Cities? cities;
//   final List<dynamic> translations;
//
//   factory TemplesDetail.fromJson(Map<String, dynamic> json){
//     return TemplesDetail(
//       id: json["id"] ?? 0,
//       name: json["name"] ?? "",
//       stateId: json["state_id"] ?? "",
//       cityId: json["city_id"] ?? "",
//       thumbnail: json["thumbnail"] ?? "",
//       openingTime: json["opening_time"] ?? "",
//       closeingTime: json["closeing_time"] ?? "",
//       employee: json["employee"],
//       //states: json["states"] == null ? null : States.fromJson(json["states"]),
//       //cities: json["cities"] == null ? null : Cities.fromJson(json["cities"]),
//       translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "state_id": stateId,
//     "city_id": cityId,
//     "thumbnail": thumbnail,
//     "opening_time": openingTime,
//     "closeing_time": closeingTime,
//     "employee": employee,
//     //"states": states?.toJson(),
//     //"cities": cities?.toJson(),
//     "translations": translations.map((x) => x).toList(),
//   };
//
// }
//


class CollectorDashModel {
  CollectorDashModel({
    required this.status,
    required this.message,
    required this.collectorDetail,
  });

  final bool status;
  final String message;
  final CollectorDetail? collectorDetail;

  factory CollectorDashModel.fromJson(Map<String, dynamic> json){
    return CollectorDashModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      collectorDetail: json["collector_detail"] == null ? null : CollectorDetail.fromJson(json["collector_detail"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "collector_detail": collectorDetail?.toJson(),
  };

}

class TemplesDetail {
  TemplesDetail({
    required this.id,
    required this.name,
    required this.stateId,
    required this.cityId,
    required this.thumbnail,
    required this.openingTime,
    required this.closeingTime,
    required this.sdm,
    required this.cities,
    required this.translations,
  });

  final int id;
  final String name;
  final String stateId;
  final String cityId;
  final String thumbnail;
  final String openingTime;
  final String closeingTime;
  final CollectorDetail? sdm;
  final Cities? cities;
  final List<dynamic> translations;

  factory TemplesDetail.fromJson(Map<String, dynamic> json){
    return TemplesDetail(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      stateId: json["state_id"] ?? "",
      cityId: json["city_id"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      openingTime: json["opening_time"] ?? "",
      closeingTime: json["closeing_time"] ?? "",
      sdm: json["sdm"] == null ? null : CollectorDetail.fromJson(json["sdm"]),
      cities: json["cities"] == null ? null : Cities.fromJson(json["cities"]),
      translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "city_id": cityId,
    "thumbnail": thumbnail,
    "opening_time": openingTime,
    "closeing_time": closeingTime,
    "sdm": sdm?.toJson(),
    "cities": cities?.toJson(),
    "translations": translations.map((x) => x).toList(),
  };

}

class CollectorDetail {
  CollectorDetail({
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
    required this.templesDetail,
    required this.totalTemple,
    required this.totalUser,
    required this.totalAmount,
    required this.totalSdm,
  });

  final int id;
  final String name;
  final String type;
  final int relCollectorId;
  final dynamic relSdmId;
  final int district;
  final String email;
  final String mobile;
  final String password;
  final String temples;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TemplesDetail> templesDetail;
  final int totalTemple;
  final int totalUser;
  final int totalAmount;
  final int totalSdm;

  factory CollectorDetail.fromJson(Map<String, dynamic> json){
    return CollectorDetail(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      relCollectorId: json["rel_collector_id"] ?? 0,
      relSdmId: json["rel_sdm_id"],
      district: json["district"] ?? 0,
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      password: json["password"] ?? "",
      temples: json["temples"] ?? "",
      status: json["status"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      templesDetail: json["temples_detail"] == null ? [] : List<TemplesDetail>.from(json["temples_detail"]!.map((x) => TemplesDetail.fromJson(x))),
      totalTemple: json["total_temple"] ?? 0,
      totalUser: json["total_user"] ?? 0,
      totalAmount: json["total_amount"] ?? 0,
      totalSdm: json["total_sdm"] ?? 0,
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
    "temples_detail": templesDetail.map((x) => x?.toJson()).toList(),
    "total_temple": totalTemple,
    "total_user": totalUser,
    "total_amount": totalAmount,
    "total_sdm": totalSdm,
  };

}

class Cities {
  Cities({
    required this.id,
    required this.city,
    required this.translations,
  });

  final int id;
  final String city;
  final List<dynamic> translations;

  factory Cities.fromJson(Map<String, dynamic> json){
    return Cities(
      id: json["id"] ?? 0,
      city: json["city"] ?? "",
      translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "translations": translations.map((x) => x).toList(),
  };

}

