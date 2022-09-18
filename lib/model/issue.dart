class Issue {
  int id = -1;
  String message = '';
  String suggestions = '';
  String delayEstimation = '';
  String walletAddress = '';
  String image = '';
  int status = -1;
  String gpsCoordinates = '';
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  int user = -1;
  int category = -1;
  String order = '';
  Issue();

  Issue.fromJson(Map<String, dynamic> json)
      : id = json['pk'] ?? -1,
        message = json['message'] ?? "",
        suggestions = json['suggestions'] ?? "",
        delayEstimation = json['delay_estimation'] ?? "",
        image = json['image'] ?? "",
        walletAddress = json['wallet_address'] ?? "",
        status = json['status'] ?? -1,
        gpsCoordinates = json['gps_coordinates'] ?? "",
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        user = json['user'] ?? -1,
        category = json['category'] ?? -1,
        order = json['order'] ?? "";

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "suggestions": suggestions,
    "delay_estimation": delayEstimation,
    // "wallet_address": walletAddress,
    "image": image,
    "status": status,
    "gps_coordinates": gpsCoordinates,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
    "user": user,
    "category": category,
    "order": order,
  };

}