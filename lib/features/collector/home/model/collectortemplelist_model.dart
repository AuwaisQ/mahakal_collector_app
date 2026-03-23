class CollectorTempleListModel {
  CollectorTempleListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final Data? data;

  factory CollectorTempleListModel.fromJson(Map<String, dynamic> json){
    return CollectorTempleListModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.juniorOfficer,
    required this.totalTemples,
    required this.temples,
  });

  final JuniorOfficer? juniorOfficer;
  final int? totalTemples;
  final List<TempleList> temples;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      juniorOfficer: json["junior_officer"] == null ? null : JuniorOfficer.fromJson(json["junior_officer"]),
      totalTemples: json["total_temples"],
      temples: json["temples"] == null ? [] : List<TempleList>.from(json["temples"]!.map((x) => TempleList.fromJson(x))),
    );
  }

}

class JuniorOfficer {
  JuniorOfficer({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.designation,
    required this.department,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? designation;
  final String? department;

  factory JuniorOfficer.fromJson(Map<String, dynamic> json){
    return JuniorOfficer(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"],
      designation: json["designation"],
      department: json["department"],
    );
  }

}

class TempleList {
  TempleList({
    required this.assignmentId,
    required this.templeId,
    required this.name,
    required this.shortDescription,
    required this.state,
    required this.city,
    required this.thumbnail,
    required this.openingTime,
    required this.closeingTime,
    required this.status,
    required this.assignedAt,
  });

  final int? assignmentId;
  final int? templeId;
  final String? name;
  final String? shortDescription;
  final String? state;
  final String? city;
  final String? thumbnail;
  final String? openingTime;
  final String? closeingTime;
  final int? status;
  final DateTime? assignedAt;

  factory TempleList.fromJson(Map<String, dynamic> json){
    return TempleList(
      assignmentId: json["assignment_id"],
      templeId: json["temple_id"],
      name: json["name"],
      shortDescription: json["short_description"],
      state: json["state"],
      city: json["city"],
      thumbnail: json["thumbnail"],
      openingTime: json["opening_time"],
      closeingTime: json["closeing_time"],
      status: json["status"],
      assignedAt: DateTime.tryParse(json["assigned_at"] ?? ""),
    );
  }

}
