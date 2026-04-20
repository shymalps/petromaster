class Question {
  final String id;
  final String? staffId;
  final String classId;
  final String subjectId;
  final String topicId;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String optionE;
  final String questionText;
  final String correctAnswer;
  final String explanation;
  final String? passageCode;
  final String passageParent;
  final String? passage;
  final String status;

  Question({
    required this.id,
    this.staffId,
    required this.classId,
    required this.subjectId,
    required this.topicId,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.optionE,
    required this.questionText,
    required this.correctAnswer,
    required this.explanation,
    this.passageCode,
    required this.passageParent,
    this.passage,
    required this.status,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id']?.toString() ?? '',
      staffId: json['staffid']?.toString(),
      classId: json['class_id']?.toString() ?? '',
      subjectId: json['subject_id']?.toString() ?? '',
      topicId: json['topic_id']?.toString() ?? '',
      optionA: json['optiona']?.toString() ?? '',
      optionB: json['optionb']?.toString() ?? '',
      optionC: json['optionc']?.toString() ?? '',
      optionD: json['optiond']?.toString() ?? '',
      optionE: json['optione']?.toString() ?? '',
      questionText: json['qns']?.toString() ?? '',
      correctAnswer: json['ans']?.toString() ?? '',
      explanation: json['explanation']?.toString() ?? '',
      passageCode: json['passagecode']?.toString(),
      passageParent: json['passageparent']?.toString() ?? '0',
      passage: json['passage']?.toString(),
      status: json['status']?.toString() ?? '1',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'staffid': staffId,
      'class_id': classId,
      'subject_id': subjectId,
      'topic_id': topicId,
      'optiona': optionA,
      'optionb': optionB,
      'optionc': optionC,
      'optiond': optionD,
      'optione': optionE,
      'qns': questionText,
      'ans': correctAnswer,
      'explanation': explanation,
      'passagecode': passageCode,
      'passageparent': passageParent,
      'passage': passage,
      'status': status,
    };
  }
}