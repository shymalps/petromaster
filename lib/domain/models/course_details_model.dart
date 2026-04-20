class CourseDetailsResponse {
  final String status;
  final String message;
  final Course1 data;

  CourseDetailsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CourseDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CourseDetailsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: Course1.fromJson(json['data']),
    );
  }
}

class Course1 {
  final String siteCourseId;
  final String relatedCourseId;
  final String course1;
  final String subName;
  final String orgAmount;
  final String offerAmount;
  final String footerTag;
  final String highlight;
  final String profile;
  final String overview;
  final String specifications;
  final String requirements;
  final String duration;
  final String? lectures;
  final String? students;
  final String language;
  final String? previewVideo;
  final List<Staff> staff;

  Course1({
    required this.siteCourseId,
    required this.relatedCourseId,
    required this.course1,
    required this.subName,
    required this.orgAmount,
    required this.offerAmount,
    required this.footerTag,
    required this.highlight,
    required this.profile,
    required this.overview,
    required this.specifications,
    required this.requirements,
    required this.duration,
    this.lectures,
    this.students,
    required this.language,
    this.previewVideo,
    required this.staff,
  });

  factory Course1.fromJson(Map<String, dynamic> json) {
    return Course1(
      siteCourseId: json['site_courseid']?.toString() ?? '',
      relatedCourseId: json['related_courseid']?.toString() ?? '',
      course1: json['course'] ?? '',
      subName: json['sub_name'] ?? '',
      orgAmount: json['org_amount']?.toString() ?? '0',
      offerAmount: json['offer_amount']?.toString() ?? '0',
      footerTag: json['footer_tag'] ?? '',
      highlight: json['highlight']?.toString() ?? '0',
      profile: json['profile'] ?? '',
      overview: json['overview'] ?? '',
      specifications: json['specifications'] ?? '',
      requirements: json['requirements'] ?? '',
      duration: json['duration'] ?? '',
      lectures: json['lectures']?.toString(),
      students: json['students']?.toString(),
      language: json['language'] ?? '',
      previewVideo: json['preview_video'],
      staff: (json['staff'] as List<dynamic>?)
              ?.map((e) => Staff.fromJson(e))
              .toList() ??
          [],
    );
  }

  // Convenience getter: first instructor's name (for single-instructor UI)
  String get staffname => staff.isNotEmpty ? staff.first.name : '';

  // Convenience getter: all instructor names joined
  String get allStaffNames => staff.map((s) => s.name).join(', ');
}

class Staff {
  final String name;
  final String gender;
  final String phone;
  final String email;
  final String qualification;
  final String? profImage;

  Staff({
    required this.name,
    required this.gender,
    required this.phone,
    required this.email,
    required this.qualification,
    this.profImage,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      qualification: json['qualification'] ?? '',
      profImage: json['prof_image'],
    );
  }

  // Returns first letter of name for avatar
  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';
}