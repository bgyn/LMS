import 'package:lms/feature/course/domain/model/lesson_model.dart';

class CourseModel {
  final String? id;
  final String? title;
  final int? price;
  final String? description;
  final String? categories;
  final String? thumbnail;
  final InstructorModel? instructor;
  final List<LessonModel>? lessons;

  CourseModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.categories,
    this.thumbnail,
    this.instructor,
    this.lessons,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      categories: json['categories'],
      instructor: json['instructor'] != null
          ? InstructorModel.fromJson(json['instructor'])
          : null,
      thumbnail: json['thumbnail'],
      lessons: json['lessons'] != null
          ? (json['lessons'] as List)
              .map((e) => LessonModel.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'price': price,
      'description': description,
      'categories': categories,
      'thumbnail': thumbnail,
      'instructor': instructor?.toJson(),
      'lessons': lessons?.map((e) => e.toJson()).toList(),
    };
  }
}

class InstructorModel {
  final String? id;
  final String? name;

  InstructorModel({
    this.id,
    this.name,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
