class TrainingNote {
  final String tnoteId;
  final String subjectId;
  final String topicId;
  final String title;
  final String description;
  final String createdAt;
  final String dateTime;

  TrainingNote({
    required this.tnoteId,
    required this.subjectId,
    required this.topicId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.dateTime,
  });

  factory TrainingNote.fromJson(Map<String, dynamic> json) {
    return TrainingNote(
      tnoteId: json['tnote_id'] ?? '',
      subjectId: json['subject_id'] ?? '',
      topicId: json['topic_id'] ?? '',
      title: json['title'] ?? '',
      description: json['descp'] ?? '',
      createdAt: json['created_at'] ?? '',
      dateTime: json['date_time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tnote_id': tnoteId,
      'subject_id': subjectId,
      'topic_id': topicId,
      'title': title,
      'descp': description,
      'created_at': createdAt,
      'date_time': dateTime,
    };
  }
}
