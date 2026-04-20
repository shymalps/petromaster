class AdminProfile {
  final String profileId;
  final String profileName;
  final String dashName;
  final String miniName;
  final String title;
  final String logo;
  final String? subDays;
  final String secureMod;
  final String examPermission;
  final String billNo;
  final String noticeboard;
  final String homeType;
  final String zoom;
  final String certificateNum;

  AdminProfile({
    required this.profileId,
    required this.profileName,
    required this.dashName,
    required this.miniName,
    required this.title,
    required this.logo,
     this.subDays,
    required this.secureMod,
    required this.examPermission,
    required this.billNo,
    required this.noticeboard,
    required this.homeType,
    required this.zoom,
    required this.certificateNum,
  });

  factory AdminProfile.fromJson(Map<String, dynamic> json) {
    return AdminProfile(
      profileId: json['profile_id'] as String,
      profileName: json['profile_name'] as String,
      dashName: json['dash_name'] as String,
      miniName: json['mini_name'] as String,
      title: json['title'] as String,
      logo: json['logo'] as String,
      subDays: json['sub_days'],
      secureMod: json['secure_mod'] as String,
      examPermission: json['exam_permission'] as String,
      billNo: json['bill_no'] as String,
      noticeboard: json['noticeboard'] as String,
      homeType: json['home_type'] as String,
      zoom: json['zoom'] as String,
      certificateNum: json['certificate_num'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'profile_name': profileName,
      'dash_name': dashName,
      'mini_name': miniName,
      'title': title,
      'logo': logo,
      'sub_days': subDays,
      'secure_mod': secureMod,
      'exam_permission': examPermission,
      'bill_no': billNo,
      'noticeboard': noticeboard,
      'home_type': homeType,
      'zoom': zoom,
      'certificate_num': certificateNum,
    };
  }
}
