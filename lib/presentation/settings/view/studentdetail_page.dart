import 'dart:convert';
import 'dart:io';
import 'package:petromaster/presentation/Learn/viewmodel/getstudentresponse.dart';
import 'package:petromaster/presentation/common/controller/studentresponcecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:petromaster/app/config/theme/text.dart';
import 'package:petromaster/core/helpers/appbarhelper.dart';
import '../../../app/Di/dimensions.dart';
import '../../../app/config/theme/colors.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({super.key});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
 final studentCtrl = Get.find<GetStudentResponseController>();
  final profileimg = Get.arguments as String;

  @override
  void initState() {
    super.initState();

    // Data is already fetched from settings page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(
        title: 'Student Details',
        leading: true,
      ),
      body: Obx(() {
        // Show loading indicator
        if (studentCtrl.isloading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 3,
                ),
                SizedBox(height: Di.screenWidth * 0.05),
                AppTextHelper.subHead(
                  text: 'Loading student details...',
                  fcolor: Colors.grey,
                ),
              ],
            ),
          );
        }

        // Show error if userId is null
        if (studentCtrl.studentData == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedAlertCircle,
                  size: Di.screenWidth * 0.2,
                  color: Colors.grey,
                ),
                SizedBox(height: Di.screenWidth * 0.05),
                AppTextHelper.mainHead(
                  text: 'No Data Available',
                  fcolor: Colors.grey,
                ),
                SizedBox(height: Di.screenWidth * 0.02),
                AppTextHelper.subHead(
                  text: 'Unable to load student details',
                  fcolor: Colors.grey,
                ),
              ],
            ),
          );
        }

        // Display student details
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                _buildProfileCard(profileimg),

                SizedBox(height: Di.screenWidth * 0.04),

                // Personal Information
                _buildSectionTitle('Personal Information'),
                SizedBox(height: Di.screenWidth * 0.02),
                _buildInfoCard([
                  _buildInfoRow(
                    icon: HugeIcons.strokeRoundedStudent,
                    label: 'student name',
                    value: studentCtrl.studentData?.name ?? 'N/A',
                  ),
                  _buildInfoRow(
                    icon: HugeIcons.strokeRoundedCalendar01,
                    label: 'Date of birth',
                    value: studentCtrl.studentData?.dob ?? 'N/A',
                  ),
                  _buildInfoRow(
                    icon: HugeIcons.strokeRoundedContact01,
                    label: 'Phone Number',
                    value: studentCtrl.studentData?.phone ?? 'N/A',
                  ),
                 _buildInfoRow(
  icon: HugeIcons.strokeRoundedBitcoinLocation,
  label: 'Address',
  value: _displayValue(studentCtrl.studentData?.address),
),
                ]),

                SizedBox(height: Di.screenWidth * 0.04),

                // Academic Information
                _buildSectionTitle('Academic Information'),
                SizedBox(height: Di.screenWidth * 0.02),
                _buildInfoCard([
                  // _buildInfoRow(
                  //   icon: HugeIcons.strokeRoundedSchool01,
                  //   label: 'Course',
                  //   value: studentCtrl.studentData?.studyMode ?? 'N/A',
                  // ),
                  _buildInfoRow(
                    icon: HugeIcons.strokeRoundedBook02,
                    label: 'Batch',
                    value: studentCtrl.studentData?.classId ?? 'N/A',
                  ),
                  // _buildInfoRow(
                  //   icon: HugeIcons.strokeRoundedCalendar01,
                  //   label: 'Enrollment Date',
                  //   value: _formatDate(studentCtrl.studentData?.expireDate),
                  // ),
                  _buildInfoRow(
                    icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                    label: 'Status',
                    value: studentCtrl.studentData?.status ?? 'N/A',
                    valueColor:
                        _getStatusColor(studentCtrl.studentData?.status),
                  ),
                  _buildInfoRow(
                    icon: HugeIcons.strokeRoundedGraduationScroll,
                    label: 'Student Position',
                    value: studentCtrl.studentData?.position ?? 'N/A',
                  ),
                  _buildInfoRow(
                    icon: HugeIcons.strokeRoundedMasterCard,
                    label: 'Studymode',
                    value: studentCtrl.studentData?.studyMode ?? 'N/A',
                  ),
                  _buildInfoRow(
                    icon: HugeIcons.strokeRoundedFileVerified,
                    label: 'Level',
                   value: _getLevel(studentCtrl.studentData?.enabledLevels),
                  ),
                ]),

                SizedBox(height: Di.screenWidth * 0.04),

                // Guardian Information (if available)
                // if (studentCtrl.studentData?.name != null)
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       _buildSectionTitle('Guardian Information'),
                //       SizedBox(height: Di.screenWidth * 0.02),
                //       _buildInfoCard([
                //         _buildInfoRow(
                //           icon: HugeIcons.strokeRoundedUserCircle,
                //           label: 'Guardian Name',
                //           value: studentCtrl.studentData?.name ?? 'N/A',
                //         ),
                //         _buildInfoRow(
                //           icon: HugeIcons.strokeRoundedCall,
                //           label: 'Guardian Contact',
                //           value: studentCtrl.studentData?.pnumber?? 'N/A',
                //         ),
                //       ]),
                //       SizedBox(height: Di.screenWidth * 0.04),
                //     ],
                //   ),

                // Address Information (if available)
                // if (studentCtrl.studentData?.address != null)
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       _buildSectionTitle('Study History'),
                //       SizedBox(height: Di.screenWidth * 0.02),
                //       _buildInfoCard([
                //         _buildInfoRow(
                //           icon: HugeIcons.strokeRoundedAirplayLine,
                //           label: 'Watched vedios',
                //           value: studentCtrl.studentData?.seenVideo ?? 'N/A',
                //           isMultiline: true,
                //         ),
                //         _buildInfoRow(
                //           icon: HugeIcons.strokeRoundedDocumentAttachment,
                //           label: 'Watched Notes',
                //           value: studentCtrl.studentData?.seenNote ?? 'N/A',
                //           isMultiline: true,
                //         ),
                //         _buildInfoRow(
                //           icon: HugeIcons.strokeRoundedMusicNoteSquare02,
                //           label: 'Watched audios',
                //           value: studentCtrl.studentData?.seenAudio ?? 'N/A',
                //           isMultiline: true,
                //         ),
                //         _buildInfoRow(
                //           icon: HugeIcons.strokeRoundedPdf01,
                //           label: 'Watched pdf',
                //           value: studentCtrl.studentData?.seenPpt ?? 'N/A',
                //           isMultiline: true,
                //         ),
                //       ]),
                //     ],
                //   ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProfileCard(String imgurl) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(Di.screenWidth * 0.04),
      child: Column(
        children: [
          CircleAvatar(
            radius: Di.screenWidth * 0.12,
            backgroundColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Di.screenWidth * 0.12),
              child: _buildImage(
                imgurl,
                Di.screenWidth * 0.22,
                Di.screenWidth * 0.22,
              ),
            ),
          ),
          SizedBox(height: Di.screenWidth * 0.03),
          AppTextHelper.mainHead(
            text: studentCtrl.studentData?.name ?? 'Student Name',
            fcolor: Colors.white,
          ),
          SizedBox(height: Di.screenWidth * 0.01),
          AppTextHelper.subHead(
            text: studentCtrl.studentData?.phone ?? 'phone not avilable',
            fcolor: Colors.white.withOpacity(0.9),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return AppTextHelper.mainHead(
      text: title,
      fcolor: Colors.black87,
    );
  }
  String _getLevel(String? enabledLevels) {
  if (enabledLevels == null || enabledLevels.isEmpty) return 'N/A';

  try {
    final decoded = jsonDecode(enabledLevels);
    return decoded['level']?.toString() ?? 'N/A';
  } catch (e) {
    return 'N/A';
  }
}
String _displayValue(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'N/A';
  }
  return value;
}

  Widget _buildImage(String imageUrl, double width, double height) {
    if (imageUrl.isEmpty) {
      return HugeIcon(
        icon: HugeIcons.strokeRoundedUserCircle,
        size: width * 0.5,
        color: AppColors.primary,
      );
    }

    if (imageUrl.startsWith('http')) {
      // Network image
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return HugeIcon(
            icon: HugeIcons.strokeRoundedUserCircle,
            size: width * 0.5,
            color: AppColors.primary,
          );
        },
      );
    } else if (imageUrl.startsWith('file://')) {
      // Local file path
      return Image.file(
        File(imageUrl.replaceFirst('file://', '')),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return HugeIcon(
            icon: HugeIcons.strokeRoundedUserCircle,
            size: width * 0.5,
            color: AppColors.primary,
          );
        },
      );
    } else {
      // Asset image
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return HugeIcon(
            icon: HugeIcons.strokeRoundedUserCircle,
            size: width * 0.5,
            color: AppColors.primary,
          );
        },
      );
    }
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoRow({
    required dynamic icon,
    required String label,
    required dynamic value,
    Color? valueColor,
    bool isMultiline = false,
  }) {
    return Padding(
      padding: EdgeInsets.all(Di.screenWidth * 0.04),
      child: Row(
        crossAxisAlignment:
            isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildIconWidget(icon),
          ),
          SizedBox(width: Di.screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: valueColor ?? Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: isMultiline ? null : 1,
                  overflow: isMultiline ? null : TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconWidget(dynamic icon) {
    if (icon is IconData) {
      return Icon(icon, color: AppColors.primary);
    } else if (icon is Widget) {
      return icon;
    } else {
      // Assume it's a HugeIcons value
      return HugeIcon(icon: icon, color: AppColors.primary);
    }
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'N/A';
    try {
      if (date is String) {
        final dateTime = DateTime.parse(date);
        return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      }
      return date.toString();
    } catch (e) {
      return 'N/A';
    }
  }

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'inactive':
        return Colors.red;
      case 'suspended':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
