class TopicData {
  final String topicId;
  final String userId;
  final String subjectId;
  final String chapter;
  final String topics;
  final String description;
  final DateTime createdAt;
  final int videoCount;
  final int audioCount;
  final int notesCount;
  final int viewedVideoCount;
  final int viewedAudioCount;
  final int viewedNotesCount;

  TopicData({
    required this.topicId,
    required this.userId,
    required this.subjectId,
    required this.chapter,
    required this.topics,
    required this.description,
    required this.createdAt,
    required this.videoCount,
    required this.audioCount,
    required this.notesCount,
    required this.viewedVideoCount,
    required this.viewedAudioCount,
    required this.viewedNotesCount,
  });

  factory TopicData.fromJson(Map<String, dynamic> json) {
    return TopicData(
      topicId: json['topic_id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      subjectId: json['subject_id']?.toString() ?? '',
      chapter: json['chapter']?.toString() ?? '',
      topics: json['topics']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          int.parse(json['created_at']?.toString() ?? '0') * 1000),
      videoCount: int.parse(json['video_count']?.toString() ?? '0'),
      audioCount: int.parse(json['audio_count']?.toString() ?? '0'),
      notesCount: int.parse(json['notes_count']?.toString() ?? '0'),
      viewedVideoCount: int.parse(json['viewed_video_count']?.toString() ?? '0'),
      viewedAudioCount: int.parse(json['viewed_audio_count']?.toString() ?? '0'),
      viewedNotesCount: int.parse(json['viewed_notes_count']?.toString() ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic_id': topicId,
      'user_id': userId,
      'subject_id': subjectId,
      'chapter': chapter,
      'topics': topics,
      'description': description,
      'created_at': createdAt.millisecondsSinceEpoch ~/ 1000,
      'video_count': videoCount,
      'audio_count': audioCount,
      'notes_count': notesCount,
      'viewed_video_count': viewedVideoCount,
      'viewed_audio_count': viewedAudioCount,
      'viewed_notes_count': viewedNotesCount,
    };
  }

  TopicData copyWith({
    String? topicId,
    String? userId,
    String? subjectId,
    String? chapter,
    String? topics,
    String? description,
    DateTime? createdAt,
    int? videoCount,
    int? audioCount,
    int? notesCount,
    int? viewedVideoCount,
    int? viewedAudioCount,
    int? viewedNotesCount,
  }) {
    return TopicData(
      topicId: topicId ?? this.topicId,
      userId: userId ?? this.userId,
      subjectId: subjectId ?? this.subjectId,
      chapter: chapter ?? this.chapter,
      topics: topics ?? this.topics,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      videoCount: videoCount ?? this.videoCount,
      audioCount: audioCount ?? this.audioCount,
      notesCount: notesCount ?? this.notesCount,
      viewedVideoCount: viewedVideoCount ?? this.viewedVideoCount,
      viewedAudioCount: viewedAudioCount ?? this.viewedAudioCount,
      viewedNotesCount: viewedNotesCount ?? this.viewedNotesCount,
    );
  }
}