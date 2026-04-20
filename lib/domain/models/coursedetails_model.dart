class Course {
  final String siteCourseId;
  final String relatedCourseId;
  final String course;
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
  final String lectures;
  final String students;
  final String language;
  final String? previewVideo;
  final String categoriesImg;
  final String staffname;

  Course({
    required this.siteCourseId,
    required this.relatedCourseId,
    required this.course,
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
    required this.lectures,
    required this.students,
    required this.language,
    this.previewVideo,
    required this.categoriesImg,
    required this.staffname
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      siteCourseId: json['site_courseid'] as String? ?? '',
      relatedCourseId: json['related_courseid'] as String? ?? '',
      course: json['course'] as String? ?? '',
      subName: json['sub_name'] as String? ?? '',
      orgAmount: json['org_amount'] as String? ?? '',
      offerAmount: json['offer_amount'] as String? ?? '',
      footerTag: json['footer_tag'] as String? ?? '',
      highlight: json['highlight'] as String? ?? '',
      profile: json['profile'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      specifications: json['specifications'] as String? ?? '',
      requirements: json['requirements'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      lectures: json['lectures'] as String? ?? '',
      students: json['students'] as String? ?? '',
      language: json['language'] as String? ?? '',
      previewVideo: json['preview_video'] as String?,
      categoriesImg: json['categories_img'] as String? ?? '',
      staffname: json['staff_name'] as String? ?? '',

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'site_courseid': siteCourseId,
      'related_courseid': relatedCourseId,
      'course': course,
      'sub_name': subName,
      'org_amount': orgAmount,
      'offer_amount': offerAmount,
      'footer_tag': footerTag,
      'highlight': highlight,
      'profile': profile,
      'overview': overview,
      'specifications': specifications,
      'requirements': requirements,
      'duration': duration,
      'lectures': lectures,
      'students': students,
      'language': language,
      'preview_video': previewVideo,
      'categories_img': categoriesImg,
      'staff_name': staffname
    };
  }
}