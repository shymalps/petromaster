import 'package:petromaster/AuthPref.dart';
import 'package:petromaster/app/config/routes/route_name.dart';
import 'package:petromaster/core/constant/constants.dart';
import 'package:petromaster/domain/models/course_details_model.dart';
import 'package:petromaster/packages/instamojo/lib/src/model/payment_request.dart';
import 'package:petromaster/packages/instamojo/lib/src/screen/instapay.dart';
import 'package:petromaster/presentation/Learn/viewmodel/coursedetailvm.dart';
import 'package:petromaster/presentation/common/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/res/assets/images.dart';
import '../../../../../domain/models/courselist_model.dart';



// ─── User Detail Dialog ──────────────────────────────────────────────────────
class _UserDetailDialog extends StatefulWidget {
  final void Function(Map<String, String> userData) onSubmit;
  const _UserDetailDialog({required this.onSubmit});

  @override
  State<_UserDetailDialog> createState() => _UserDetailDialogState();
}

class _UserDetailDialogState extends State<_UserDetailDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _dobController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Your Details'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.trim().length < 8 ? 'Enter a valid phone' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (v) => v == null || v.length < 6 ? 'Min 6 characters' : null,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                keyboardType: TextInputType.datetime,
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    _dobController.text = picked.toIso8601String().split('T').first;
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onSubmit({
                'name': _nameController.text.trim(),
                'email': _emailController.text.trim(),
                'phone': _phoneController.text.trim(),
                'password': _passwordController.text,
                'address': _addressController.text.trim(),
                'dob': _dobController.text.trim(),
              });
              Navigator.of(context).pop();
            }
          },
          child: const Text('Continue'),
        ),
      ],
    );
  }
}

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key, required this.courseListModel});
  final CourseListModel courseListModel;

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showStickyBar = false;
  int _selectedTab = 0;

  late final CoursedetailVM _vm;

  static const _tabLabels = ["Overview", "Specification", "Instructors"];

  @override
  void initState() {
    super.initState();
    print(
      '==================> Course Detail Page Initialized for courseId: ${widget.courseListModel.siteCourseId}',
    );
    _vm = Get.put(
      CoursedetailVM(),
      tag: widget.courseListModel.siteCourseId,
    );
    _vm.getCourse2(widget.courseListModel.siteCourseId);

    _scrollController.addListener(() {
      final show = _scrollController.offset > 260;
      if (show != _showStickyBar) setState(() => _showStickyBar = show);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Get.delete<CoursedetailVM>(tag: widget.courseListModel.siteCourseId);
    super.dispose();
  }

  bool _hasDiscount(String orgAmount, String offerAmount) {
    try {
      final org = double.parse(orgAmount);
      final off = double.parse(offerAmount);
      return org > 0 && off > 0 && org != off;
    } catch (_) {
      return false;
    }
  }

  String _discountPercent(String orgAmount, String offerAmount) {
    try {
      final org = double.parse(orgAmount);
      final off = double.parse(offerAmount);
      if (org <= 0) return "SALE";
      return "${((org - off) / org * 100).round()}% OFF";
    } catch (_) {
      return "SALE";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        body: Obx(() {
          final isLoading = _vm.isloading.value;
          final course = _vm.ongoingCourses2;

          final profileUrl =
              course?.profile ?? widget.courseListModel.profile ?? '';
          final subName =
              course?.subName ?? widget.courseListModel.subName ?? '';
          final courseLabel =
              course?.course1 ?? widget.courseListModel.course ?? '';
          final orgAmount = course?.orgAmount ??
              widget.courseListModel.orgAmount?.toString() ??
              '0';
          final offerAmount = course?.offerAmount ??
              widget.courseListModel.offerAmount?.toString() ??
              '0';
          final hasDisc = _hasDiscount(orgAmount, offerAmount);

          return Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // ── Hero ─────────────────────────────────────
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    backgroundColor: const Color(0xFF1A1A2E),
                    leading: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 18),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          FadeInImage.assetNetwork(
                            placeholder: AppImages.coursedefault,
                            image: profileUrl,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (_, __, ___) => Image.asset(
                              AppImages.coursedefault,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.15),
                                  Colors.black.withOpacity(0.72),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _Pill(
                                      label: courseLabel,
                                      color: const Color(0xFF1DB954),
                                    ),
                                    if (hasDisc) ...[
                                      const SizedBox(width: 8),
                                      _Pill(
                                        label: _discountPercent(
                                            orgAmount, offerAmount),
                                        color: const Color(0xFFFF4757),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  subName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    height: 1.25,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ── Stats Row ─────────────────────────────────
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 36,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF5B6BF8),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                _StatItem(
                                  icon: Icons.access_time_rounded,
                                  value: course?.duration ??
                                      widget.courseListModel.duration ??
                                      '—',
                                  label: "Duration",
                                  color: const Color(0xFFFF6B6B),
                                ),
                                const _VertDivider(),
                                _StatItem(
                                  icon: Icons.play_circle_outline_rounded,
                                  value: course?.lectures ?? '—',
                                  label: "Lessons",
                                  color: const Color(0xFF5B6BF8),
                                ),
                                const _VertDivider(),
                                _StatItem(
                                  icon: Icons.people_alt_outlined,
                                  value: course?.students ?? '—',
                                  label: "Students",
                                  color: const Color(0xFF1DB954),
                                ),
                                const _VertDivider(),
                                _StatItem(
                                  icon: Icons.language_outlined,
                                  value: (course?.language ??
                                          widget.courseListModel.language ??
                                          '—')
                                      .split(',')
                                      .first
                                      .trim(),
                                  label: "Language",
                                  color: const Color(0xFFFFC107),
                                ),
                              ],
                            ),
                    ),
                  ),

                  // ── Tab Bar ───────────────────────────────────
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _TabBarDelegate(
                      selectedTab: _selectedTab,
                      onTabSelected: (i) =>
                          setState(() => _selectedTab = i),
                      labels: _tabLabels,
                    ),
                  ),

                  // ── Tab Content ───────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
                      child: isLoading
                          ? const _Skeleton()
                          : AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: _selectedTab == 0
                                  ? _OverviewTab(
                                      key: const ValueKey(0),
                                      course: course,
                                    )
                                  : _selectedTab == 1
                                      ? _SpecificationTab(
                                          key: const ValueKey(1),
                                          course: course,
                                        )
                                      : _InstructorsTab(
                                          key: const ValueKey(2),
                                          staff: course?.staff ?? [],
                                        ),
                            ),
                    ),
                  ),
                ],
              ),

              // ── Sticky Buy Bar ────────────────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _BuyBar(
                  classId: widget.courseListModel.siteCourseId,
                  orgAmount: orgAmount,
                  offerAmount: offerAmount,
                  hasDiscount: hasDisc,
                  showStickyBar: _showStickyBar,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ─── Tab: Overview ────────────────────────────────────────────────────────────

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({super.key, required this.course});
  final Course1? course;

  @override
  Widget build(BuildContext context) {
    final overview = course?.overview ?? '';
    final language = course?.language ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle("About this course"),
        const SizedBox(height: 10),
        overview.isNotEmpty
            ? Text(
                overview,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF555555),
                  height: 1.7,
                ),
              )
            : const _EmptyNote("No overview available."),
        if (language.isNotEmpty) ...[
          const SizedBox(height: 24),
          const _SectionTitle("Languages"),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: language
                .split(',')
                .map((l) => _LangPill(label: l.trim()))
                .toList(),
          ),
        ],
      ],
    );
  }
}

// ─── Tab: Specification ───────────────────────────────────────────────────────

class _SpecificationTab extends StatelessWidget {
  const _SpecificationTab({super.key, required this.course});
  final Course1? course;

  @override
  Widget build(BuildContext context) {
    final specs = course?.specifications ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle("Specifications"),
        const SizedBox(height: 10),
        specs.isNotEmpty
            ? Text(
                specs,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF555555),
                  height: 1.7,
                ),
              )
            : const _EmptyNote("No specification details available."),
      ],
    );
  }
}

// ─── Tab: Instructors ─────────────────────────────────────────────────────────

class _InstructorsTab extends StatelessWidget {
  const _InstructorsTab({super.key, required this.staff});
  final List<Staff> staff;

  @override
  Widget build(BuildContext context) {
    if (staff.isEmpty) {
      return const _EmptyNote("No instructor information available.");
    }
    return Column(
      children: staff
          .map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _InstructorCard(staff: s),
              ))
          .toList(),
    );
  }
}

class _InstructorCard extends StatelessWidget {
  const _InstructorCard({required this.staff});
  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final hasProfImage =
        staff.profImage != null && staff.profImage!.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        children: [
          // Avatar
          hasProfImage
              ? CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(staff.profImage!),
                )
              : Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF5B6BF8), Color(0xFF7C3AED)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      staff.initial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  staff.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                if (staff.qualification.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    staff.qualification,
                    style: const TextStyle(
                        fontSize: 12, color: Color(0xFF777777)),
                  ),
                ],
                if (staff.email.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.email_outlined,
                          size: 13, color: Color(0xFF999999)),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          staff.email,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xFF999999)),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Buy Bar ──────────────────────────────────────────────────────────────────

class _BuyBar extends StatelessWidget {
  const _BuyBar({
    required this.orgAmount,
    required this.offerAmount,
    required this.hasDiscount,
    required this.showStickyBar,
    required this.classId,
  });

  final String orgAmount;
  final String offerAmount;
  final bool hasDiscount;
  final bool showStickyBar;
  final String classId;
  // ── For LOGGED-IN users ──────────────────────────────────────────────────
  Future<void> _purchaseCourse(
    BuildContext context, {
    required String studentId,
    required String classId,
    required String instamojoId,
    required String mojoEmail,
  }) async {
    final url = Uri.parse('${Constants.appBaseUrl}purchase_course');
    final body = {
      'student_id': studentId,
      'class_id': classId,
      'instamojo_id': instamojoId,
      'mojo_email': mojoEmail,
    };
    try {
      final response = await http.post(url, body: body, headers: {
        'api-key': Constants.apiKey,
      });
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: const Text('Course purchased successfully!'),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Purchase Failed'),
            content: const Text('Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred. Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // ── For GUEST users ──────────────────────────────────────────────────────
Future<void> _registerUser(
  BuildContext context,
  Map<String, String> userData, {
  required String classId,
  required String instamojoId,
}) async {
  final url = Uri.parse('${Constants.appBaseUrl}registration');
  final body = {
    'name':     userData['name']     ?? '',
    'email':    userData['email']    ?? '',
    'password': userData['password'] ?? '',
    'class_id': classId,              // ✅ now a real classId
    'address':  userData['address']  ?? '',
    'dob':      userData['dob']      ?? '',
    'phone':    userData['phone']    ?? '',
    'instamojo_id': instamojoId,
    'mojo_email': userData['email'] ?? '',
  };
  try {
    final response = await http.post(url, body: body, headers: {
      'api-key': Constants.apiKey,
    });
    if (response.statusCode == 200) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Payment successful. Please login to continue.'),
          actions: [
            TextButton(
              onPressed: () => Get.offAllNamed(RouteName.login), // ✅ go to login
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Failed'),
          content: const Text('Please try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('An error occurred. Please try again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    final displayPrice =
        (offerAmount != '0' && offerAmount != orgAmount) ? offerAmount : orgAmount;

  Future<void> handleBuyNow() async {
  final isLoggedIn = await AuthPreferences.isLoggedIn();

  final amount = double.tryParse(
        (offerAmount != '0' && offerAmount != orgAmount)
            ? offerAmount
            : orgAmount,
      ) ?? 0.0;

  final redirectUrl = '${Constants.appBaseUrl}payment_redirect';

  Map<String, String> guestData = {};

  if (!isLoggedIn) {
    // ── Guest: collect user details before payment ──
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => _UserDetailDialog(
        onSubmit: (data) => Navigator.of(context).pop(data),
      ),
    );
    if (result == null) return;
    guestData = result;
  }

  // ── Get profile data for logged-in user ──
  String buyerName = '';
  String buyerEmail = '';
  String buyerPhone = '';
  String studentId = '';

  if (isLoggedIn) {
    final profileVM = Get.find<Profilevm>();
    buyerName  = profileVM.profileData?.name    ?? '';
    buyerEmail = profileVM.profileData?.email   ?? '';
    buyerPhone = profileVM.profileData?.phone   ?? '';
    studentId  = profileVM.profileData?.studentId ?? '';
  }

  if (!context.mounted) return;

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PaymentScreen(
        clientId: '1ccmvZrfT7XWHq4kNIYDQoY1H45QwXWS9L2i2hnY',
        clientsecret: 'W6H7k0qeaZo31M66mQGEsuKkW0j5tJBBv8hGPrxAGuy9YNxZjdrzMZuG10sB0BR4DDMd9tea94jXzcijO6VvmdL5iZkELYiLllJIunAQ8O5wKCSg6bZVl6YflLnUUgs9',
        paymentRequest: InstamojoPaymentRequest(
          purpose: 'Course Purchase',
          amount: amount,
          buyerName: isLoggedIn ? buyerName : (guestData['name'] ?? ''),
          email:     isLoggedIn ? buyerEmail : (guestData['email'] ?? ''),
          phone:     isLoggedIn ? buyerPhone : (guestData['phone'] ?? ''),
          redirectUrl: redirectUrl,
        ),

        onPaymentSuccess: (response) async {
          if (isLoggedIn) {
            // ── Logged-in: purchase course using profile data ──
            await _purchaseCourse(
              context,
              studentId:   studentId,
              classId:     classId,                                    // ✅ fixed
              instamojoId: response['MojId'] ?? '',                    // ✅ fixed key
              mojoEmail:   response['payment_details']?['email'] ?? buyerEmail, // ✅ fixed
            );
          } else {
            // ── Guest: register + enroll ──
            await _registerUser(
              instamojoId: response['MojId'] ?? '',     
              context,
              guestData,
              classId: classId, // ✅ fixed (was passing courseName string before)
            );
          }
        },

        onPaymentError: (error) {
          if (!context.mounted) return;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Payment Failed'),
              content: Text(error),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },

        onPaymentCancel: () {},
      ),
    ),
  );
}
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(20, showStickyBar ? 16 : 14, 20,
          20 + MediaQuery.of(context).padding.bottom),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "₹$displayPrice",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              if (hasDiscount)
                Text(
                  "₹$orgAmount",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFAAAAAA),
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: handleBuyNow,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B6BF8), Color(0xFF7C3AED)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5B6BF8).withOpacity(0.38),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bolt_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "Buy Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Small helpers ─────────────────────────────────────────────────────────────

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (i) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: i == 0 ? 20 : 14,
          width: i == 0
              ? 140
              : i == 4
                  ? 200
                  : double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}

class _EmptyNote extends StatelessWidget {
  const _EmptyNote(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 14, color: Color(0xFF999999)),
        ),
      ),
    );
  }
}

class _LangPill extends StatelessWidget {
  const _LangPill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD0D3FF)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5B6BF8),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String? value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          value ?? '—',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF999999)),
        ),
      ],
    );
  }
}

class _VertDivider extends StatelessWidget {
  const _VertDivider();

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 36, color: const Color(0xFFEEEEEE));
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Color(0xFF1A1A2E),
      ),
    );
  }
}

// ─── Tab Bar Delegate ──────────────────────────────────────────────────────────

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  const _TabBarDelegate({
    required this.selectedTab,
    required this.onTabSelected,
    required this.labels,
  });
  final int selectedTab;
  final ValueChanged<int> onTabSelected;
  final List<String> labels;

  @override
  double get minExtent => 52;
  @override
  double get maxExtent => 52;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: 52,
      child: Row(
        children: labels.asMap().entries.map((entry) {
          final selected = entry.key == selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: selected
                          ? const Color(0xFF5B6BF8)
                          : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: selected
                          ? const Color(0xFF5B6BF8)
                          : const Color(0xFF999999),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate old) =>
      old.selectedTab != selectedTab;
}
