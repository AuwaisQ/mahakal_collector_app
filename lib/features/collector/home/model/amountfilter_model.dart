class CollectorAmountFilterModel {
  CollectorAmountFilterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final CollectorDetail? data;

  factory CollectorAmountFilterModel.fromJson(Map<String, dynamic> json){
    return CollectorAmountFilterModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : CollectorDetail.fromJson(json["data"]),
    );
  }

}

class CollectorDetail {
  CollectorDetail({
    required this.templeId,
    required this.totalAmount,
    required this.cashAmount,
    required this.onlineAmount,
    required this.startDate,
    required this.endDate,
    required this.totalOrders,
  });

  final dynamic templeId;
  final dynamic totalAmount;
  final dynamic cashAmount;
  final dynamic onlineAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  final dynamic totalOrders;

  factory CollectorDetail.fromJson(Map<String, dynamic> json){
    return CollectorDetail(
      templeId: json["temple_id"],
      totalAmount: json["total_amount"],
      cashAmount: json["cash_amount"],
      onlineAmount: json["online_amount"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      totalOrders: json["total_orders"],
    );
  }

}
