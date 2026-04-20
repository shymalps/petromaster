class StudentResponse {
  final String? status;
  final String? message;
  final List<StudentData>? data;

  StudentResponse({
    this.status,
    this.message,
    this.data,
  });

  factory StudentResponse.fromJson(Map<String, dynamic> json) {
    return StudentResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<StudentData>.from(
              json['data'].map((x) => StudentData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class StudentData {
  final String? studentId;
  final String? userId;
  final String? classId;
  final String? name;
  final String? sname;
  final String? srname;
  final String? rname;
  final String? nname;
  final String? cname;
  final String? position;
  final String? pnumber;
  final String? dob;
  final String? address;
  final String? expdate;
  final String? phone;
  final String? expireDate;
  final String? seenVideo;
  final String? seenNote;
  final String? seenAudio;
  final String? seenPpt;
  final String? ip;
  final String? deviceId;
  final String? status;
  final String? studyMode;
  final String? previousReqPermission;
  final String? prevTimes;
  final String? enabledLevels;
  final String? createdAt;

  StudentData({
    this.studentId,
    this.userId,
    this.classId,
    this.name,
    this.sname,
    this.srname,
    this.rname,
    this.nname,
    this.cname,
    this.position,
    this.pnumber,
    this.dob,
    this.address,
    this.expdate,
    this.phone,
    this.expireDate,
    this.seenVideo,
    this.seenNote,
    this.seenAudio,
    this.seenPpt,
    this.ip,
    this.deviceId,
    this.status,
    this.studyMode,
    this.previousReqPermission,
    this.prevTimes,
    this.enabledLevels,
    this.createdAt,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      studentId: json['student_id'],
      userId: json['user_id'],
      classId: json['class_id'],
      name: json['name'],
      sname: json['sname'],
      srname: json['srname'],
      rname: json['rname'],
      nname: json['nname'],
      cname: json['cname']?.toString(),
      position: json['position']?.toString(),
      pnumber: json['pnumber'],
      dob: json['dob'],
      address: json['address'],
      expdate: json['expdate'],
      phone: json['phone'],
      expireDate: json['expire_date'],
      seenVideo: json['seen_video'],
      seenNote: json['seen_note'],
      seenAudio: json['seen_audio'],
      seenPpt: json['seen_ppt'],
      ip: json['ip'],
      deviceId: json['device_id'],
      status: json['status'],
      studyMode: json['study_mode']?.toString(),
      previousReqPermission: json['previous_req_permission'],
      prevTimes: json['prev_times'],
      enabledLevels: json['enabled_levels']?.toString(),
      createdAt: json['created_at'],
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
    };
  }
}
