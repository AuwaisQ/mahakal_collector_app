class SdmDashboardModel {
  SdmDashboardModel({
    required this.status,
    required this.message,
    required this.sdmDetail,
  });

  final bool status;
  final String message;
  final SdmDetail? sdmDetail;

  factory SdmDashboardModel.fromJson(Map<String, dynamic> json){
    return SdmDashboardModel(
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
    required this.templesDetail,
    required this.totalTemple,
    required this.totalUser,
    required this.totalAmount,
    required this.totalEmployee,
  });

  final int id;
  final String name;
  final String type;
  final int relCollectorId;
  final dynamic relSdmId;
  final dynamic district;
  final String email;
  final String mobile;
  final String password;
  final String temples;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SDMTemplesDetail> templesDetail;
  final int totalTemple;
  final int totalUser;
  final int totalAmount;
  final int totalEmployee;

  factory SdmDetail.fromJson(Map<String, dynamic> json){
    return SdmDetail(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      relCollectorId: json["rel_collector_id"] ?? 0,
      relSdmId: json["rel_sdm_id"],
      district: json["district"],
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      password: json["password"] ?? "",
      temples: json["temples"] ?? "",
      status: json["status"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      templesDetail: json["temples_detail"] == null ? [] : List<SDMTemplesDetail>.from(json["temples_detail"]!.map((x) => SDMTemplesDetail.fromJson(x))),
      totalTemple: json["total_temple"] ?? 0,
      totalUser: json["total_user"] ?? 0,
      totalAmount: json["total_amount"] ?? 0,
      totalEmployee: json["total_employee"] ?? 0,
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
    "total_employee": totalEmployee,
  };

}

class SDMTemplesDetail {
  SDMTemplesDetail({
    required this.id,
    required this.name,
    required this.stateId,
    required this.cityId,
    required this.thumbnail,
    required this.openingTime,
    required this.closeingTime,
    required this.employee,
    required this.states,
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
  final Employee? employee;
  final States? states;
  final Cities? cities;
  final List<dynamic> translations;

  factory SDMTemplesDetail.fromJson(Map<String, dynamic> json){
    return SDMTemplesDetail(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      stateId: json["state_id"] ?? "",
      cityId: json["city_id"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      openingTime: json["opening_time"] ?? "",
      closeingTime: json["closeing_time"] ?? "",
      employee: json["employee"] == null ? null : Employee.fromJson(json["employee"]),
      states: json["states"] == null ? null : States.fromJson(json["states"]),
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
    "employee": employee?.toJson(),
    "states": states?.toJson(),
    "cities": cities?.toJson(),
    "translations": translations.map((x) => x).toList(),
  };

}

class Cities {
  Cities({
    required this.id,
    required this.city,
    required this.countryId,
    required this.stateId,
    required this.shortDesc,
    required this.description,
    required this.images,
    required this.image,
    required this.sliderImage,
    required this.latitude,
    required this.longitude,
    required this.famousFor,
    required this.festivalsAndEvents,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  final int id;
  final String city;
  final int countryId;
  final int stateId;
  final String shortDesc;
  final String description;
  final String images;
  final String image;
  final String sliderImage;
  final String latitude;
  final String longitude;
  final String famousFor;
  final String festivalsAndEvents;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> translations;

  factory Cities.fromJson(Map<String, dynamic> json){
    return Cities(
      id: json["id"] ?? 0,
      city: json["city"] ?? "",
      countryId: json["country_id"] ?? 0,
      stateId: json["state_id"] ?? 0,
      shortDesc: json["short_desc"] ?? "",
      description: json["description"] ?? "",
      images: json["images"] ?? "",
      image: json["image"] ?? "",
      sliderImage: json["slider_image"] ?? "",
      latitude: json["latitude"] ?? "",
      longitude: json["longitude"] ?? "",
      famousFor: json["famous_for"] ?? "",
      festivalsAndEvents: json["festivals_and_events"] ?? "",
      status: json["status"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "country_id": countryId,
    "state_id": stateId,
    "short_desc": shortDesc,
    "description": description,
    "images": images,
    "image": image,
    "slider_image": sliderImage,
    "latitude": latitude,
    "longitude": longitude,
    "famous_for": famousFor,
    "festivals_and_events": festivalsAndEvents,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "translations": translations.map((x) => x).toList(),
  };

}

class Employee {
  Employee({
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
  });

  final int id;
  final String name;
  final String type;
  final dynamic relCollectorId;
  final int relSdmId;
  final dynamic district;
  final String email;
  final String mobile;
  final String password;
  final String temples;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Employee.fromJson(Map<String, dynamic> json){
    return Employee(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      type: json["type"] ?? "",
      relCollectorId: json["rel_collector_id"],
      relSdmId: json["rel_sdm_id"] ?? 0,
      district: json["district"],
      email: json["email"] ?? "",
      mobile: json["mobile"] ?? "",
      password: json["password"] ?? "",
      temples: json["temples"] ?? "",
      status: json["status"] ?? 0,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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
  };

}

class States {
  States({
    required this.id,
    required this.name,
    required this.logo,
    required this.countryId,
  });

  final int id;
  final String name;
  final String logo;
  final int countryId;

  factory States.fromJson(Map<String, dynamic> json){
    return States(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      logo: json["logo"] ?? "",
      countryId: json["country_id"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "country_id": countryId,
  };

}
