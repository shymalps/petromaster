class ZoomMeeting {
  final String meetingId;
  final String classId;
  final String staffId;
  final String topic;
  final String duration;
  final String meetingUrl;
  final String? otherUrl;
  final String joinUrl;
  final String meetingPassword;
  final String encryptedPassword;
  final int scheduleDate;
  final int createDate;
  final String meetingNumber;
  final String staffName;

  ZoomMeeting({
    required this.meetingId,
    required this.classId,
    required this.staffId,
    required this.topic,
    required this.duration,
    required this.meetingUrl,
    this.otherUrl,
    required this.joinUrl,
    required this.meetingPassword,
    required this.encryptedPassword,
    required this.scheduleDate,
    required this.createDate,
    required this.meetingNumber,
    required this.staffName,
  });

  factory ZoomMeeting.fromJson(Map<String, dynamic> json) {
    return ZoomMeeting(
      meetingId: json['meeting_id'] ?? '',
      classId: json['class_id'] ?? '',
      staffId: json['staff_id'] ?? '',
      topic: json['topic'] ?? '',
      duration: json['duration'] ?? '',
      meetingUrl: json['meeting_url'] ?? '',
      otherUrl: json['other_url'],
      joinUrl: json['join_url'] ?? '',
      meetingPassword: json['meeting_password'] ?? '',
      encryptedPassword: json['encrypted_password'] ?? '',
      scheduleDate: int.tryParse(json['schedule_date'].toString()) ?? 0,
      createDate: int.tryParse(json['create_date'].toString()) ?? 0,
      meetingNumber: json['meetingid'] ?? '',
      staffName: json['staff_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meeting_id': meetingId,
      'class_id': classId,
      'staff_id': staffId,
      'topic': topic,
      'duration': duration,
      'meeting_url': meetingUrl,
      'other_url': otherUrl,
      'join_url': joinUrl,
      'meeting_password': meetingPassword,
      'encrypted_password': encryptedPassword,
      'schedule_date': scheduleDate,
      'create_date': createDate,
      'meetingid': meetingNumber,
      'staff_name': staffName,
    };
  }

  DateTime get scheduleDateTime => 
      DateTime.fromMillisecondsSinceEpoch(scheduleDate * 1000);
  
  DateTime get createDateTime => 
      DateTime.fromMillisecondsSinceEpoch(createDate * 1000);
}