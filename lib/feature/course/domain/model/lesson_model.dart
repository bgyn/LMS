class LessonModel {
  final String? id;
  final String? courseId;
  final String? description;
  final List<SubLesson>? subLessons;

  LessonModel({this.id, this.courseId, this.description, this.subLessons});

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['_id'],
      courseId: json['course_id'],
      description: json['description'],
      subLessons: json['sub_lessons'] != null
          ? (json['sub_lessons'] as List)
              .map((e) => SubLesson.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'course_id': courseId,
      'description': description,
      'sub_lessons': subLessons?.map((e) => e.toJson()).toList(),
    };
  }
}

class SubLesson {
  final String? id;
  final String? title;
  final String? url;

  SubLesson({this.id, this.title, this.url});

  factory SubLesson.fromJson(Map<String, dynamic> json) {
    return SubLesson(
      id: json['_id'],
      title: json['title'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'url': url,
    };
  }
}
