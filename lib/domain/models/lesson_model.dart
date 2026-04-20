class LessonList {
  final List<Lesson> data;
  final int count;

  LessonList({
    required this.data,
    required this.count,
  });

  factory LessonList.fromJson(Map<String, dynamic> json) {
    return LessonList(
      data:
          (json['data'] as List).map((item) => Lesson.fromJson(item)).toList(),
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'count': count,
    };
  }
}

class Lesson {
  final String lessonId;
  final String topicId;
  final String lesson;

  Lesson({
    required this.lessonId,
    required this.topicId,
    required this.lesson,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lession_id'] as String,
      topicId: json['topicid'] as String,
      lesson: json['lession'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lession_id': lessonId,
      'topicid': topicId,
      'lession': lesson,
    };
  }
}
