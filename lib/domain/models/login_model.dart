class LoginModel {
  final String studentId;
  final String userId;
  final String classId;
  final String name;
  final String sname;
  final String srname;
  final String rname;
  final String nname;
  final String? cname;
  final String? position;
  final String pnumber;
  final String dob;
  final String address;
  final String expdate;
  final String phone;
  final String expireDate;
  final String seenVideo;
  final String seenNote;
  final String seenAudio;
  final String seenPpt;
  final String ip;
  final String? deviceId;
  final String status;
  final String? studyMode;
  final String previousReqPermission;
  final String prevTimes;
  final String? enabledLevels;
  final String createdAt;
  final String utype;

  LoginModel({
    required this.studentId,
    required this.userId,
    required this.classId,
    required this.name,
    required this.sname,
    required this.srname,
    required this.rname,
    required this.nname,
    this.cname,
    this.position,
    required this.pnumber,
    required this.dob,
    required this.address,
    required this.expdate,
    required this.phone,
    required this.expireDate,
    required this.seenVideo,
    required this.seenNote,
    required this.seenAudio,
    required this.seenPpt,
    required this.ip,
    this.deviceId,
    required this.status,
    required this.studyMode,
    required this.previousReqPermission,
    required this.prevTimes,
    required this.enabledLevels,
    required this.createdAt,
    required this.utype,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      studentId: json['student_id'] as String,
      userId: json['user_id'] as String,
      classId: json['class_id'] as String,
      name: json['name'] as String,
      sname: json['sname'] as String,
      srname: json['srname'] as String,
      rname: json['rname'] as String,
      nname: json['nname'] as String,
      cname: json['cname'] as String?,
      position: json['position'] as String?,
      pnumber: json['pnumber'] as String,
      dob: json['dob'] as String,
      address: json['address'] as String,
      expdate: json['expdate'] as String,
      phone: json['phone'] as String,
      expireDate: json['expire_date'] as String,
      seenVideo: json['seen_video'] as String,
      seenNote: json['seen_note'] as String,
      seenAudio: json['seen_audio'] as String,
      seenPpt: json['seen_ppt'] as String,
      ip: json['ip'] as String,
      deviceId: json['device_id'] as String?,
      status: json['status'] as String,
      studyMode: json['study_mode'] as String?,
      previousReqPermission: json['previous_req_permission'] as String,
      prevTimes: json['prev_times'] as String,
      enabledLevels: json['enabled_levels'] as String?,
      createdAt: json['created_at'] as String,
      utype: json['utype'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'user_id': userId,
      'class_id': classId,
      'name': name,
      'sname': sname,
      'srname': srname,
      'rname': rname,
      'nname': nname,
      'cname': cname,
      'position': position,
      'pnumber': pnumber,
      'dob': dob,
      'address': address,
      'expdate': expdate,
      'phone': phone,
      'expire_date': expireDate,
      'seen_video': seenVideo,
      'seen_note': seenNote,
      'seen_audio': seenAudio,
      'seen_ppt': seenPpt,
      'ip': ip,
      'device_id': deviceId,
      'status': status,
      'study_mode': studyMode,
      'previous_req_permission': previousReqPermission,
      'prev_times': prevTimes,
      'enabled_levels': enabledLevels,
      'created_at': createdAt,
      'utype': utype,
    };
  }
}
