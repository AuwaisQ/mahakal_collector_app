class CollectorTempleListModel {
  CollectorTempleListModel({
    required this.status,
    required this.message,
    required this.collectorId,
    required this.sdmId,
    required this.sdmName,
    required this.totalTemples,
    required this.templeList,
  });

  final bool status;
  final String message;
  final int collectorId;
  final int sdmId;
  final String sdmName;
  final int totalTemples;
  final List<TempleList> templeList;

  factory CollectorTempleListModel.fromJson(Map<String, dynamic> json){
    return CollectorTempleListModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      collectorId: json["collector_id"] ?? 0,
      sdmId: json["sdm_id"] ?? 0,
      sdmName: json["sdm_name"] ?? "",
      totalTemples: json["total_temples"] ?? 0,
      templeList: json["temple_list"] == null ? [] : List<TempleList>.from(json["temple_list"]!.map((x) => TempleList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "collector_id": collectorId,
    "sdm_id": sdmId,
    "sdm_name": sdmName,
    "total_temples": totalTemples,
    "temple_list": templeList.map((x) => x?.toJson()).toList(),
  };

}

class TempleList {
  TempleList({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.openingTime,
    required this.closeingTime,
    required this.translations,
  });

  final int id;
  final String name;
  final String thumbnail;
  final String openingTime;
  final String closeingTime;
  final List<dynamic> translations;

  factory TempleList.fromJson(Map<String, dynamic> json){
    return TempleList(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      thumbnail: json["thumbnail"] ?? "",
      openingTime: json["opening_time"] ?? "",
      closeingTime: json["closeing_time"] ?? "",
      translations: json["translations"] == null ? [] : List<dynamic>.from(json["translations"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail": thumbnail,
    "opening_time": openingTime,
    "closeing_time": closeingTime,
    "translations": translations.map((x) => x).toList(),
  };

}
