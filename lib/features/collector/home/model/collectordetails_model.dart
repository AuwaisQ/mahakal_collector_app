class CollectorDetailsModel {
  CollectorDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory CollectorDetailsModel.fromJson(Map<String, dynamic> json){
    return CollectorDetailsModel(
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
    required this.shortDescription,
    required this.details,
    required this.state,
    required this.city,
    required this.district,
    required this.thumbnail,
    required this.openingTime,
    required this.closeingTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.collectionSummary,
  });

  final int? id;
  final String? name;
  final String? shortDescription;
  final String? details;
  final String? state;
  final String? city;
  final String? district;
  final String? thumbnail;
  final String? openingTime;
  final String? closeingTime;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CollectionSummary? collectionSummary;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      name: json["name"],
      shortDescription: json["short_description"],
      details: json["details"],
      state: json["state"],
      city: json["city"],
      district: json["district"],
      thumbnail: json["thumbnail"],
      openingTime: json["opening_time"],
      closeingTime: json["closeing_time"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      collectionSummary: json["collection_summary"] == null ? null : CollectionSummary.fromJson(json["collection_summary"]),
    );
  }

}

class CollectionSummary {
  CollectionSummary({
    required this.totalUser,
    required this.totalAmount,
    required this.cashAmount,
    required this.onlineAmount,
    required this.pujaAmount,
    required this.darshanAmount,
    required this.lockerAmount,
    required this.bhojanAmount,
    required this.totalOrders,
  });

  final int? totalUser;
  final int? totalAmount;
  final int? cashAmount;
  final int? onlineAmount;
  final int? pujaAmount;
  final int? darshanAmount;
  final int? lockerAmount;
  final int? bhojanAmount;
  final int? totalOrders;

  factory CollectionSummary.fromJson(Map<String, dynamic> json){
    return CollectionSummary(
      totalUser: json["total_user"],
      totalAmount: json["total_amount"],
      cashAmount: json["cash_amount"],
      onlineAmount: json["online_amount"],
      pujaAmount: json["puja_amount"],
      darshanAmount: json["darshan_amount"],
      lockerAmount: json["locker_amount"],
      bhojanAmount: json["bhojan_amount"],
      totalOrders: json["total_orders"],
    );
  }

}
