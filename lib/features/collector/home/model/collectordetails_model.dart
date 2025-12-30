class CollectorDetailsModel {
  CollectorDetailsModel({
    required this.status,
    required this.message,
    required this.temple,
    required this.collectionSummary,
  });

  final bool status;
  final String message;
  final Temple? temple;
  final CollectionSummary? collectionSummary;

  factory CollectorDetailsModel.fromJson(Map<String, dynamic> json){
    return CollectorDetailsModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      temple: json["temple"] == null ? null : Temple.fromJson(json["temple"]),
      collectionSummary: json["collection_summary"] == null ? null : CollectionSummary.fromJson(json["collection_summary"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "temple": temple?.toJson(),
    "collection_summary": collectionSummary?.toJson(),
  };

}

class CollectionSummary {
  CollectionSummary({
    required this.totalUser,
    required this.verifiedUser,
    required this.unverifiedUser,
    required this.totalAmount,
    required this.cashAmount,
    required this.onlineAmount,
    required this.pujaAmount,
    required this.darshanAmount,
    required this.lockerAmount,
    required this.bhojanAmount,
  });

  final int totalUser;
  final int verifiedUser;
  final int unverifiedUser;
  final int totalAmount;
  final int cashAmount;
  final int onlineAmount;
  final int pujaAmount;
  final int darshanAmount;
  final int lockerAmount;
  final int bhojanAmount;

  factory CollectionSummary.fromJson(Map<String, dynamic> json){
    return CollectionSummary(
      totalUser: json["total_user"] ?? 0,
      verifiedUser: json["verified_user"] ?? 0,
      unverifiedUser: json["unverified_user"] ?? 0,
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
    "verified_user": verifiedUser,
    "unverified_user": unverifiedUser,
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
    required this.images,
    required this.image,
    required this.sliderImage,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
  });

  final int id;
  final String city;
  final int countryId;
  final int stateId;
  final String images;
  final String image;
  final String sliderImage;
  final String latitude;
  final String longitude;
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
      images: json["images"] ?? "",
      image: json["image"] ?? "",
      sliderImage: json["slider_image"] ?? "",
      latitude: json["latitude"] ?? "",
      longitude: json["longitude"] ?? "",
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
    "images": images,
    "image": image,
    "slider_image": sliderImage,
    "latitude": latitude,
    "longitude": longitude,
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
