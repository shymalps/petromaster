import 'dart:convert';

class NoteModel {
  final String notesId;
  final String subjectId;
  final String topicId;
  final String title;
  final String descp;
  final List<String> fileName;
  final String? size;
  final String createdAt;
  final String dateTime;
  final String fileType;

  NoteModel({
    required this.notesId,
    required this.subjectId,
    required this.topicId,
    required this.title,
    required this.descp,
    required this.fileName,
    this.size,
    required this.createdAt,
    required this.dateTime,
    required this.fileType,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      notesId: json['notes_id'] ?? '',
      subjectId: json['subject_id'] ?? '',
      topicId: json['topic_id'] ?? '',
      title: json['title'] ?? '',
      descp: json['descp'] ?? '',
      fileName: List<String>.from(jsonDecode(json['file_name'] ?? '[]')),
      size: json['size'],
      createdAt: json['created_at'] ?? '',
      dateTime: json['date_time'] ?? '',
      fileType: json['file_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes_id': notesId,
      'subject_id': subjectId,
      'topic_id': topicId,
      'title': title,
      'descp': descp,
      'file_name': jsonEncode(fileName),
      'size': size,
      'created_at': createdAt,
      'date_time': dateTime,
      'file_type': fileType,
    };
  }
}
