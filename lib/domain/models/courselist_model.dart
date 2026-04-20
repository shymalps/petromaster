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
    };
  }
}
