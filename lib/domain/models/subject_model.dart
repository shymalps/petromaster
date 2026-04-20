class Subject {
  final String subjectId;
  final String subjectName;
  final int topicCount;
  final int videoCount;
  final int audioCount;
  final int notesCount;
  final int viewedVideoCount;
  final int viewedAudioCount;
  final int viewedNotesCount;

  Subject({
    required this.subjectId,
    required this.subjectName,
    required this.topicCount,
    required this.videoCount,
    required this.audioCount,
    required this.notesCount,
    required this.viewedVideoCount,
    required this.viewedAudioCount,
    required this.viewedNotesCount,
  });

  // Factory constructor to create a Subject from JSON
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subject_id'].toString(),
      subjectName: json['subject_name'],
      topicCount: json['topic_count'] as int,
      videoCount: json['video_count'] as int,
      audioCount: json['audio_count'] as int,
      notesCount: json['notes_count'] as int,
      viewedVideoCount: json['viewed_video_count'] as int,
      viewedAudioCount: json['viewed_audio_count'] as int,
      viewedNotesCount: json['viewed_notes_count'] as int,
    );
  }

  // Method to convert Subject to JSON
  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_name': subjectName,
      'topic_count': topicCount,
      'video_count': videoCount,
      'audio_count': audioCount,
      'notes_count': notesCount,
      'viewed_video_count': viewedVideoCount,
      'viewed_audio_count': viewedAudioCount,
      'viewed_notes_count': viewedNotesCount,
    };
  }

  // Copy with method for immutable updates
  Subject copyWith({
    String? subjectId,
    String? subjectName,
    int? topicCount,
    int? videoCount,
    int? audioCount,
    int? notesCount,
    int? viewedVideoCount,
    int? viewedAudioCount,
    int? viewedNotesCount,
  }) {
    return Subject(
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      topicCount: topicCount ?? this.topicCount,
      videoCount: videoCount ?? this.videoCount,
      audioCount: audioCount ?? this.audioCount,
      notesCount: notesCount ?? this.notesCount,
      viewedVideoCount: viewedVideoCount ?? this.viewedVideoCount,
      viewedAudioCount: viewedAudioCount ?? this.viewedAudioCount,
      viewedNotesCount: viewedNotesCount ?? this.viewedNotesCount,
    );
  }
}