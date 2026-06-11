class CourseListModel {
  final String siteCourseId;
  final String course;
  final String subName;
  final String orgAmount;
  final String offerAmount;
  final String profile;
  final String duration;
  final String lectures;
  final String language;
  final List<CourseStaff> staff; // ← NEW

  CourseListModel({
    required this.siteCourseId,
    required this.course,
    required this.subName,
    required this.orgAmount,
    required this.offerAmount,
    required this.profile,
    required this.duration,
    required this.lectures,
    required this.language,
    this.staff = const [], // ← NEW (default empty so old code won't break)
  });

  factory CourseListModel.fromJson(Map<String, dynamic> json) {
    return CourseListModel(
      siteCourseId: json['site_courseid'] ?? '',
      course: json['course'] ?? '',
      subName: json['sub_name'] ?? '',
      orgAmount: json['org_amount'] ?? '',
      offerAmount: json['offer_amount'] ?? '',
      profile: json['profile'] ?? '',
      duration: json['duration'] ?? '',
      lectures: json['lectures'] ?? '',
      language: json['language'] ?? '',
      // parse staff list if present in response
      staff: (json['staff'] as List<dynamic>?)
              ?.map((e) => CourseStaff.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'site_courseid': siteCourseId,
      'course': course,
      'sub_name': subName,
      'org_amount': orgAmount,
      'offer_amount': offerAmount,
      'profile': profile,
      'duration': duration,
      'lectures': lectures,
      'language': language,
      'staff': staff.map((s) => s.toJson()).toList(),
    };
  }
}

/// Lightweight staff model for course list cards.
class CourseStaff {
  final String name;
  final String? profImage;
  final String gender;

  const CourseStaff({
    required this.name,
    this.profImage,
    this.gender = '',
  });

  factory CourseStaff.fromJson(Map<String, dynamic> json) {
    return CourseStaff(
      name: json['name'] ?? '',
      profImage: json['prof_image']?.toString().isNotEmpty == true
          ? json['prof_image']
          : null,
      gender: json['gender'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'prof_image': profImage ?? '',
        'gender': gender,
      };

  /// First letter of name for avatar fallback
  String get initial => name.isNotEmpty ? name[0].toUpperCase() : '?';
}