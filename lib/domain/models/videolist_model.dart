class VideoModel {
  final String videoId;
  final String topicId;
  final String name;
  final String videoname;
  final int createdAt;
  final int dateTime;
  final String fileType;
  final String pMode;
  final String yLink;
  final String? description;
  final String? size;
  final String? thumbnail;

  VideoModel({
    required this.videoId,
    required this.topicId,
    required this.name,
    required this.videoname,
    required this.createdAt,
    required this.dateTime,
    required this.fileType,
    required this.pMode,
    required this.yLink,
    this.description,
    this.size,
    this.thumbnail,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoId: json['video_id'].toString(),
      topicId: json['topic_id'].toString(),
      name: json['name'] ?? '',
      videoname: json['videoname'] ?? '',
      createdAt: int.tryParse(json['created_at'].toString()) ?? 0,
      dateTime: int.tryParse(json['date_time'].toString()) ?? 0,
      fileType: json['file_type'] ?? 'v',
      pMode: json['p_mode'] ?? 'public',
      yLink: json['y_link'] ?? '0',
      description: json['description'],
      size: json['size']?.toString(),
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_id': videoId,
      'topic_id': topicId,
      'name': name,
      'videoname': videoname,
      'created_at': createdAt,
      'date_time': dateTime,
      'file_type': fileType,
      'p_mode': pMode,
      'y_link': yLink,
      'description': description,
      'size': size,
      'thumbnail': thumbnail,
    };
  }

  @override
  String toString() {
    return 'VideoModel{videoId: $videoId, topicId: $topicId, name: $name, videoname: $videoname}';
  }
}