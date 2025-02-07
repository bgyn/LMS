import 'dart:convert';

List<NotificationModel> notificationModelFromMap(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromMap(x)));

String notificationModelToMap(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class NotificationModel {
  String? id;
  String? userId;
  String? title;
  String? body;
  String? type;
  bool? isRead;
  DateTime? createdAt;

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.type,
    this.isRead,
    this.createdAt,
  });

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? body,
    String? type,
    bool? isRead,
    DateTime? createdAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
      );

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        body: json["body"],
        type: json["type"],
        isRead: json["isRead"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "body": body,
        "type": type,
        "isRead": isRead,
        "createdAt": createdAt?.toIso8601String(),
      };
}
