class StudentModel {
  final String feeStatus;
  final String userId;
  final String studentId;
  final String email;
  final String name;
  final String phone;
  final String expireDate; // keep as String, or convert to DateTime if needed
  final String status;
  final String studentClass;
  final String dob;
  final String address;
  final String profImg;

  StudentModel({
    required this.feeStatus,
    required this.userId,
    required this.studentId,
    required this.email,
    required this.name,
    required this.phone,
    required this.expireDate,
    required this.status,
    required this.studentClass,
    required this.dob,
    required this.address,
    required this.profImg,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      feeStatus: json['fee_status'] ?? '',
      userId: json['user_id'] ?? '',
      studentId: json['student_id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      expireDate: json['expire_date'] ?? '',
      status: json['status'] ?? '',
      studentClass: json['class'] ?? '',
      dob: json['dob'] ?? '',
      address: json['address'] ?? '',
      profImg: json['prof_img'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fee_status': feeStatus,
      'user_id': userId,
      'student_id': studentId,
      'email': email,
      'name': name,
      'phone': phone,
      'expire_date': expireDate,
      'status': status,
      'class': studentClass,
      'dob': dob,
      'address': address,
      'prof_img': profImg,
    };
  }
}
