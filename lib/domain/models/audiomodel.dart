// Main Response Model
class AudioResponse {
  final String status;
  final String message;
  final List<AudioData> data;
  final int count;

  AudioResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.count,
  });

  factory AudioResponse.fromJson(Map<String, dynamic> json) {
    return AudioResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<AudioData>.from(
              json['data'].map((x) => AudioData.fromJson(x)),
            )
          : [],
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
      'count': count,
    };
  }
}

// Audio Item Model
class AudioData {
  final String audioId;
  final String topicId;
  final String name;
  final String audioName;
  final String createdAt;
  final String dateTime;
  final String fileType;

  AudioData({
    required this.audioId,
    required this.topicId,
    required this.name,
    required this.audioName,
    required this.createdAt,
    required this.dateTime,
    required this.fileType,
  });

  factory AudioData.fromJson(Map<String, dynamic> json) {
    return AudioData(
      audioId: json['audio_id'] ?? '',
      topicId: json['topic_id'] ?? '',
      name: json['name'] ?? '',
      audioName: json['audioname'] ?? '',
      createdAt: json['created_at'] ?? '',
      dateTime: json['date_time'] ?? '',
      fileType: json['file_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'audio_id': audioId,
      'topic_id': topicId,
      'name': name,
      'audioname': audioName,
      'created_at': createdAt,
      'date_time': dateTime,
      'file_type': fileType,
    };
  }
}
