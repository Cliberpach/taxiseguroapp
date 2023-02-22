import 'dart:convert';

List<Notifications> notificationsFromJson(String str) =>
    List<Notifications>.from(
        json.decode(str).map((x) => Notifications.fromJson(x)));

String notificationsToJson(List<Notifications> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notifications {
  Notifications({
    this.id,
    this.userId,
    this.informacion,
    this.extra,
    this.readUser,
    this.creado,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String informacion;
  String extra;
  String readUser;
  DateTime creado;
  dynamic createdAt;
  dynamic updatedAt;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        userId: json["user_id"],
        informacion: json["informacion"],
        extra: json["extra"],
        readUser: json["read_user"],
        creado: DateTime.parse(json["creado"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "informacion": informacion,
        "extra": extra,
        "read_user": readUser,
        "creado": creado.toIso8601String(),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
