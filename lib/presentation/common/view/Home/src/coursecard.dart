import 'package:petromaster/presentation/settings/view/course_detail_page.dart';
import 'package:flutter/material.dart';
import '../../../../../app/config/theme/colors.dart';
import '../../../../../core/res/assets/images.dart';
import '../../../../../domain/models/courselist_model.dart';

// Base URL for instructor profile images — adjust to match your project constant
const String _kImageBase =
    'https://lms.petromasteracademy.com/assets/images/';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.courseListModel});
  final CourseListModel courseListModel;

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount =
        courseListModel.orgAmount != null &&
        courseListModel.offerAmount != courseListModel.orgAmount;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, animation, __) =>
                CourseDetailPage(courseListModel: courseListModel),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.06),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  ),
                  child: child,
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: SizedBox(
        width: 300,
        child: Card(
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Image Section ───────────────────────────────────
                Stack(
                  children: [
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: FadeInImage.assetNetwork(
                        placeholder: AppImages.coursedefault,
                        image: courseListModel.profile,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImages.coursedefault,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    // gradient overlay
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.55),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Category chip
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1DB954),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          courseListModel.course,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ),
                    // Discount badge
                    if (hasDiscount)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF4757),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _discountPercent(
                              courseListModel.orgAmount,
                              courseListModel.offerAmount,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // ─── Content Section ─────────────────────────────────
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseListModel.subName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _MetaChip(
                            icon: Icons.play_circle_outline_rounded,
                            label: "${courseListModel.duration}",
                            iconColor: const Color(0xFF5B6BF8),
                          ),
                          const SizedBox(width: 10),
                          _MetaChip(
                            icon: Icons.language_outlined,
                            label: courseListModel.language,
                            iconColor: const Color(0xFF1DB954),
                          ),
                        ],
                      ),

                      // ─── Instructor Strip ─────────────────────────
                      if (courseListModel.staff.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _InstructorStrip(staff: courseListModel.staff),
                      ],

                      const SizedBox(height: 14),
                      Container(height: 1, color: const Color(0xFFF0F0F0)),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "₹${courseListModel.offerAmount ?? courseListModel.orgAmount ?? '0'}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: 8),
                            Text(
                              "₹${courseListModel.orgAmount}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFAAAAAA),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                          const Spacer(),
                          // "View" pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF5B6BF8), Color(0xFF7C3AED)],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              "View",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _discountPercent(dynamic original, dynamic offer) {
    try {
      final org = double.parse(original.toString());
      final off = double.parse(offer.toString());
      if (org <= 0) return "SALE";
      final pct = ((org - off) / org * 100).round();
      return "$pct% OFF";
    } catch (_) {
      return "SALE";
    }
  }
}

// ─── Instructor Strip ────────────────────────────────────────────────────────
/// Shows stacked avatars + names for all instructors in the course card.
class _InstructorStrip extends StatelessWidget {
  const _InstructorStrip({required this.staff});
  final List<CourseStaff> staff;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Stacked avatars (max 3 shown)
        _StackedAvatars(staff: staff),
        const SizedBox(width: 8),
        // Names column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Instructors',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF999999),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                staff.map((s) => s.name).join(' • '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Overlapping circular avatars — up to 3, then "+N" badge
class _StackedAvatars extends StatelessWidget {
  const _StackedAvatars({required this.staff});
  final List<CourseStaff> staff;

  static const double _size = 30.0;
  static const double _overlap = 10.0;

  @override
  Widget build(BuildContext context) {
    final visible = staff.take(3).toList();
    final extra = staff.length - visible.length;
    final totalWidth = _size + (_overlap * (visible.length - 1)) +
        (extra > 0 ? _overlap : 0);

    return SizedBox(
      width: totalWidth,
      height: _size,
      child: Stack(
        children: [
          ...List.generate(visible.length, (i) {
            return Positioned(
              left: i * (_size - _overlap),
              child: _Avatar(staff: visible[i]),
            );
          }),
          if (extra > 0)
            Positioned(
              left: visible.length * (_size - _overlap),
              child: Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: const Color(0xFF5B6BF8),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+$extra',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.staff});
  final CourseStaff staff;

  static const double _size = 30.0;

  @override
  Widget build(BuildContext context) {
    final imageUrl = (staff.profImage != null && staff.profImage!.isNotEmpty)
        ? '$_kImageBase${staff.profImage}'
        : null;

    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: ClipOval(
        child: imageUrl != null
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _InitialAvatar(staff: staff),
              )
            : _InitialAvatar(staff: staff),
      ),
    );
  }
}

class _InitialAvatar extends StatelessWidget {
  const _InitialAvatar({required this.staff});
  final CourseStaff staff;

  // Pick a color based on gender
  Color get _bg => staff.gender == 'female'
      ? const Color(0xFFE91E8C)
      : const Color(0xFF5B6BF8);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bg,
      alignment: Alignment.center,
      child: Text(
        staff.initial,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ─── Helpers ─────────────────────────────────────────────────────────────────
class _MetaChip extends StatelessWidget {
  const _MetaChip(
      {required this.icon, required this.label, required this.iconColor});
  final IconData icon;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: iconColor),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}