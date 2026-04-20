class ExamlistModel {
  final String name;
  final String topics;
  final String date;
  final String button;
  final String examId;
  final String duration;
  final String qusCount;

  ExamlistModel({
    required this.name,
    required this.topics,
    required this.date,
    required this.button,
    required this.examId,
    required this.duration,
    required this.qusCount,
  });

  factory ExamlistModel.fromJson(Map<String, dynamic> json) {
    return ExamlistModel(
      name: json['name'] ?? '',
      topics: json['topics'] ?? '',
      date: json['date'] ?? '',
      button: json['button'] ?? '',
      examId: json['exam_id'] ?? '',
      duration: json['duration'] ?? '',
      qusCount: json['qusCount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'topics': topics,
      'date': date,
      'button': button,
      'exam_id': examId,
    };
  }
}
