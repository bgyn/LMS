import 'dart:convert';

List<MyCourseModel> myCourseModelFromMap(String str) =>
    List<MyCourseModel>.from(
        json.decode(str)["enrollment"].map((x) => MyCourseModel.fromMap(x)));

String myCourseModelToMap(List<MyCourseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class MyCourseModel {
  String? id;
  Course? course;
  String? paymentIntentId;
  String? status;
  DateTime? enrolledAt;

  MyCourseModel({
    this.id,
    this.course,
    this.paymentIntentId,
    this.status,
    this.enrolledAt,
  });

  factory MyCourseModel.fromMap(Map<String, dynamic> json) => MyCourseModel(
        id: json["_id"],
        course:
            json["courseId"] == null ? null : Course.fromMap(json["courseId"]),
        paymentIntentId: json["paymentIntentId"],
        status: json["status"],
        enrolledAt: json["enrolledAt"] == null
            ? null
            : DateTime.parse(json["enrolledAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "courseId": course?.toMap(),
        "paymentIntentId": paymentIntentId,
        "status": status,
        "enrolledAt": enrolledAt?.toIso8601String(),
      };
}

class Course {
  String? id;
  String? title;
  String? description;
  String? categories;
  int? price;
  Instructor? instructor;
  List<String>? lessons;
  String? thumbnail;

  Course({
    this.id,
    this.title,
    this.description,
    this.categories,
    this.price,
    this.instructor,
    this.lessons,
    this.thumbnail,
  });

  factory Course.fromMap(Map<String, dynamic> json) => Course(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        categories: json["categories"],
        price: json["price"],
        instructor: json["instructor"] == null
            ? null
            : Instructor.fromMap(json["instructor"]),
        lessons: json["lessons"] == null
            ? []
            : List<String>.from(json["lessons"]!.map((x) => x)),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "description": description,
        "categories": categories,
        "price": price,
        "instructor": instructor?.toMap(),
        "lessons":
            lessons == null ? [] : List<dynamic>.from(lessons!.map((x) => x)),
        "thumbnail": thumbnail,
      };
}

class Instructor {
  String? email;
  String? name;

  Instructor({
    this.email,
    this.name,
  });

  factory Instructor.fromMap(Map<String, dynamic> json) => Instructor(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "name": name,
      };
}
