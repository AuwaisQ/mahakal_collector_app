class SdmDetailsModel {
  SdmDetailsModel({
    required this.status,
    required this.message,
    required this.temple,
    required this.collectionSummary,
  });

  final bool status;
  final String message;
  final Temple? temple;
  final SDMCollectionSummary? collectionSummary;

  factory SdmDetailsModel.fromJson(Map<String, dynamic> json){
    return SdmDetailsModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      temple: json["temple"] == null ? null : Temple.fromJson(json["temple"]),
      collectionSummary: json["collection_summary"] == null ? null : SDMCollectionSummary.fromJson(json["collection_summary"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "temple": temple?.toJson(),
    "collection_summary": collectionSummary?.toJson(),
  };

}

class SDMCollectionSummary {
  SDMCollectionSummary({
    required this.totalUser,
    required this.totalAmount,
    required this.cashAmount,
    required this.onlineAmount,
    required this.pujaAmount,
    required this.darshanAmount,
    required this.lockerAmount,
    required this.bhojanAmount,
  });

  final int totalUser;
  final int totalAmount;
  final int cashAmount;
  final int onlineAmount;
  final int pujaAmount;
  final int darshanAmount;
  final int lockerAmount;
  final int bhojanAmount;

  factory SDMCollectionSummary.fromJson(Map<String, dynamic> json){
    return SDMCollectionSummary(
      totalUser: json["total_user"] ?? 0,
      totalAmount: json["total_amount"] ?? 0,
      cashAmount: json["cash_amount"] ?? 0,
      onlineAmount: json["online_amount"] ?? 0,
      pujaAmount: json["puja_amount"] ?? 0,
      darshanAmount: json["darshan_amount"] ?? 0,
      lockerAmount: json["locker_amount"] ?? 0,
      bhojanAmount: json["bhojan_amount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "total_user": totalUser,
    "total_amount": totalAmount,
    "cash_amount": cashAmount,
    "online_amount": onlineAmount,
    "puja_amount": pujaAmount,
    "darshan_amount": darshanAmount,
    "locker_amount": lockerAmount,
    "bhojan_amount": bhojanAmount,
  };

}

class Temple {
  Temple({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.details,
    required this.stateId,
    required this.cityId,
    required this.thumbnail,
    required this.openingTime,
    required this.closeingTime,
    required this.states,
    required this.cities,
    required this.translations,
  });

  final int id;
  final String name;
  final String shortDescription;
  final String details;
  final String stateId;
  final String cityId;
  final String thumbnail;
  final String openingTime;
  final String closeingTime;
  final States? states;
  final Cities? cities;
  final List<dynamic> translations;

  factory Temple.fromJson(Map<String, dynamic> json){
    return Temple(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      shortDescription: json["short_description"] ?? "",
      details: json["details"] ?? "",
      stateId: json["state_id"] ?? "",
      cityId: json["city_id"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      openingTime: json["opening_time"] ?? "",
      closeingTime: json["closeing_time"] ?? "",
      states: json["states"] == null ? null : States.fromJson(json["states"]),
      cities: json["cities"] == null ? null : Cities.fromJson(json["cities"]),
      translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_description": shortDescription,
    "details": details,
    "state_id": stateId,
    "city_id": cityId,
    "thumbnail": thumbnail,
    "opening_time": openingTime,
    "closeing_time": closeingTime,
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
