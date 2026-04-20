import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';

import '../../../../../app/config/theme/colors.dart';
import '../../../../../app/config/theme/text.dart';
import '../../../../../domain/models/examlist_model.dart';

// // Mock data from your API

class ExamCard extends StatelessWidget {
  final ExamlistModel exam;
  final Function() onTap;

  const ExamCard({super.key, required this.exam, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     AppColors.lightsecondary.withOpacity(0.5),
          //     Colors.white,
          //     AppColors.lightsecondary.withOpacity(0.5),
          //   ],
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      exam.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  _buildStatusIndicator(exam.button),
                ],
              ),
              const SizedBox(height: 12),
              AppTextHelper.caption(
                text: exam.topics,
                fcolor: const Color(0xFF6B7280),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(children: [
                        Container(
                          child: Text(
                            'Duration: ${_formatDate(exam.duration)}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ]),
                      Row(children: [
                        Container(
                          child: Text(
                            'Qus Count: ${_formatDate(exam.qusCount)}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ]),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     // Container(
                  //     //   padding: const EdgeInsets.all(6),
                  //     //   decoration: BoxDecoration(
                  //     //     color: const Color(0xFFEFF6FF),
                  //     //     borderRadius: BorderRadius.circular(8),
                  //     //   ),
                  //     //   child: SvgPicture.asset(
                  //     //     'assets/calendar.svg', // Replace with your SVG asset
                  //     //     width: 16,
                  //     //     height: 16,
                  //     //     color: const Color(0xFF3B82F6),
                  //     //   ),
                  //     // ),
                  //     const SizedBox(width: 8),
                  //     Text(
                  //       exam.date.isEmpty ? 'Available now' : _formatDate(exam.date),
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //         color: exam.date.isEmpty
                  //             ? const Color(0xFF10B981)
                  //             : const Color(0xFF6B7280),
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  _buildActionButton(exam),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    IconData icon;
    Color color;

    switch (status) {
      case 'Start Now':
        icon = Icons.access_time_filled;
        color = const Color(0xFFF59E0B);
        break;
      case 'View Result':
        icon = Icons.check_circle;
        color = const Color(0xFF10B981);
        break;
      case 'Missed':
        icon = Icons.error_outline;
        color = const Color(0xFFEF4444);
        break;
      default:
        icon = Icons.info_outline;
        color = const Color(0xFF6B7280);
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }

  Widget _buildActionButton(ExamlistModel exam) {
    return Container(
      decoration: BoxDecoration(
        gradient: _getButtonGradient(exam.button),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _getButtonColor(exam.button).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: AppTextHelper.button(
            text: exam.button,
            fcolor: AppColors.white,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  LinearGradient _getButtonGradient(String buttonText) {
    switch (buttonText) {
      case 'Start Now':
        return const LinearGradient(
          colors: [Color.fromARGB(255, 238, 215, 11), Colors.yellow],
        );
      case 'View Result':
        return const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF6EE7B7)],
        );
      case 'Missed':
        return const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFFCA5A5)],
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF6B7280), Color(0xFF9CA3AF)],
        );
    }
  }

  Color _getButtonColor(String buttonText) {
    switch (buttonText) {
      case 'Start Now':
        return const Color(0xFF6E45E2);
      case 'View Result':
        return const Color(0xFF10B981);
      case 'Missed':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  String _formatDate(String date) {
    try {
      final inputFormat = DateFormat('dd-MM-yyyy');
      final outputFormat = DateFormat('MMM dd, yyyy');
      final dateTime = inputFormat.parse(date);
      return outputFormat.format(dateTime);
    } catch (e) {
      return date;
    }
  }
}
