import 'dart:convert';

class ExamDataModel {
  final String id;
  final String examDate;
  final List<ExamInstruction> instructions;
  final String classId;
  final String subjectId;
  final String topicId;
  final String status;
  final String? academicYear;
  final String markPerQuestion;
  final String minusMark;
  final String totalTime;
  final String? subQuestions;
  final String? subOrder;
  final String? passageCount;
  final String? staffId;

  ExamDataModel({
    required this.id,
    required this.examDate,
    required this.instructions,
    required this.classId,
    required this.subjectId,
    required this.topicId,
    required this.status,
    this.academicYear,
    required this.markPerQuestion,
    required this.minusMark,
    required this.totalTime,
    this.subQuestions,
    this.subOrder,
    this.passageCount,
    this.staffId,
  });

  factory ExamDataModel.fromJson(Map<String, dynamic> json) {
    return ExamDataModel(
      id: json['id'] ?? '',
      examDate: json['examdate'] ?? '',
      instructions: (json['instructions'] != null && json['instructions'] is String)
          ? _parseInstructions(json['instructions'])
          : [],
      classId: json['class_id'] ?? '',
      subjectId: json['subject_id'] ?? '',
      topicId: json['topic_id'] ?? '',
      status: json['status'] ?? '',
      academicYear: json['academicyear'],
      markPerQuestion: json['markqns'] ?? '',
      minusMark: json['minusmark'] ?? '',
      totalTime: json['totaltime'] ?? '',
      subQuestions: json['subqns'],
      subOrder: json['suborder'],
      passageCount: json['passg_count'],
      staffId: json['staffid'],
    );
  }

  static List<ExamInstruction> _parseInstructions(String instructionsJson) {
    try {
      final List<dynamic> parsed = jsonDecode(instructionsJson);
      return parsed.map((e) => ExamInstruction.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'examdate': examDate,
      'instructions': jsonEncode(instructions.map((e) => e.toJson()).toList()),
      'class_id': classId,
      'subject_id': subjectId,
      'topic_id': topicId,
      'status': status,
      'academicyear': academicYear,
      'markqns': markPerQuestion,
      'minusmark': minusMark,
      'totaltime': totalTime,
      'subqns': subQuestions,
      'suborder': subOrder,
      'passg_count': passageCount,
      'staffid': staffId,
    };
  }
}

class ExamInstruction {
  final String direction;
  final String from;
  final String to;

  ExamInstruction({
    required this.direction,
    required this.from,
    required this.to,
  });

  factory ExamInstruction.fromJson(Map<String, dynamic> json) {
    return ExamInstruction(
      direction: json['direction'] ?? '',
      from: json['from'] ?? '',
      to: json['to'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'direction': direction,
      'from': from,
      'to': to,
    };
  }
}