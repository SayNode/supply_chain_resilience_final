class User {
  int id = -1;
  String email = '';
  String firstName = '';
  String lastName = '';
  String avatar = '';
  int balance = 0;
  User();

  User.fromJson(Map<String, dynamic> json)
      : id = json['pk'] ?? -1,
        firstName = json['first_name'] ?? "",
        lastName = json['last_name'] ?? "",
        email = json['email'] ?? "",
        avatar = json['avatar'] ?? "",
        balance = json['balance'] ?? 0;

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };

}