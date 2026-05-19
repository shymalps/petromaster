import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:petromaster/app/config/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/config/theme/colors.dart';
import '../../../../core/res/assets/images.dart';

// ─────────────────────────────────────────────
//  NAVIGATION SHELL
// ─────────────────────────────────────────────
class AppDetails extends StatefulWidget {
  const AppDetails({super.key});

  @override
  State<AppDetails> createState() => _AppDetailsState();
}

class _AppDetailsState extends State<AppDetails> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _HomeTab(),
          _AboutTab(),
          _GalleryTab(),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  BOTTOM NAV BAR
// ─────────────────────────────────────────────
class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppColors.primary,
            color: Colors.grey.shade600,
            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Home'),
              GButton(icon: Icons.info_outline, text: 'About'),
              // GButton(icon: Icons.photo_library_outlined, text: 'Gallery'),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTap,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HOME TAB
// ─────────────────────────────────────────────
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TopNavBar(),
          _HeroSection(),
          _WelcomeSection(),
          _AccreditationCard(),
          _WhatWeOfferCard(),
          _WhyChooseUsCard(),
          _StayTunedBanner(),
          _FooterBar(),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ABOUT TAB
// ─────────────────────────────────────────────
class _AboutTab extends StatelessWidget {
  const _AboutTab();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TopNavBar(),
          _AboutHeader(),
          _CompanyInfoSection(),
          _FooterBar(),
        ],
      ),
    );
  }
}

class _AboutHeader extends StatelessWidget {
  const _AboutHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Us',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A2B4A),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Who we are and what we stand for',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          Divider(thickness: 1, color: Color(0xFFE0E0E0)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  GALLERY TAB
// ─────────────────────────────────────────────
class _GalleryTab extends StatelessWidget {
  const _GalleryTab();

  // Add your network image URLs here when ready
  static const List<String> _imageUrls = [];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: _TopNavBar()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A2B4A),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Moments from our academy',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Divider(thickness: 1, color: Colors.grey.shade200),
              ],
            ),
          ),
        ),
        if (_imageUrls.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  size: 72,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 16),
                Text(
                  'Gallery coming soon',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Check back later for photos',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            sliver: SliverMasonryGrid(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              delegate: SliverChildBuilderDelegate(
                (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: _imageUrls[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 120,
                      color: Colors.grey.shade200,
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 120,
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                childCount: _imageUrls.length,
              ),
            ),
          ),
        const SliverToBoxAdapter(child: _FooterBar()),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  TOP NAV BAR
// ─────────────────────────────────────────────
class _TopNavBar extends StatelessWidget {
  const _TopNavBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        AppImages.logo,
                        width: 36,
                        height: 36,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PETRO MASTER',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A2B4A),
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'ACADEMY',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE74C3C),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Get.toNamed(RouteName.login),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HERO SECTION
// ─────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  static const _orange = Color(0xFFE0670C);
  static const _navy = Color(0xFF041B3D);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0xFFF3F3F3),
      height: 480,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            right: -(w * 0.18),
            child: Container(
              width: w * 0.88,
              height: w * 0.88,
              decoration: const BoxDecoration(
                color: _orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: (w * 0.6),
            child: Container(
              width: w * 0.5,
              height: w * 0.5,
              decoration: const BoxDecoration(
                color: _orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 36,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 28,
                      spreadRadius: -6,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/animationimg.png',
                  height: w * 0.75,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '"Learn with Confidence.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: _navy,
                    height: 1.15,
                  ),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 900),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Work with Competence."',
                      textStyle: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: _navy,
                        height: 1.15,
                      ),
                      speed: const Duration(milliseconds: 150),
                      cursor: '|',
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  WELCOME SECTION
// ─────────────────────────────────────────────
class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Welcome',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                height: 1.3,
              ),
              children: [
                TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(color: Color(0xFF1A2B4A)),
                ),
                TextSpan(
                  text: 'Petro Master\nAcademy!',
                  style: TextStyle(color: Color(0xFFE74C3C)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Diving into Excellence in Oil & Gas Training!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "We're thrilled to launch Petro Master Academy — your trusted partner for world-class Drilling and Workover Operations in both offshore and onshore training.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ACCREDITATION CARD
// ─────────────────────────────────────────────
class _AccreditationCard extends StatelessWidget {
  const _AccreditationCard();

  @override
  Widget build(BuildContext context) {
    return const _InfoCard(
      icon: Icons.verified_outlined,
      iconColor: Color(0xFF27AE60),
      title: 'Accreditation Pursuit',
      body:
          "We're gearing up to achieve IWCF & IADC certifications — setting the benchmark for safety, skills, and industry readiness!",
    );
  }
}

// ─────────────────────────────────────────────
//  WHAT WE OFFER CARD
// ─────────────────────────────────────────────
class _WhatWeOfferCard extends StatelessWidget {
  const _WhatWeOfferCard();

  static const _bullets = [
    'Expert-led courses in Drilling, Well Control, & Offshore Operations',
    'Hands-on simulations and global best practices',
    'Tailored programs for professionals & freshers',
  ];

  @override
  Widget build(BuildContext context) {
    return const _BulletCard(
      icon: Icons.menu_book_outlined,
      iconColor: Color(0xFF2980B9),
      title: 'What We Offer',
      bullets: _bullets,
    );
  }
}

// ─────────────────────────────────────────────
//  WHY CHOOSE US CARD
// ─────────────────────────────────────────────
class _WhyChooseUsCard extends StatelessWidget {
  const _WhyChooseUsCard();

  static const _bullets = [
    'Industry-aligned curriculum',
    'State-of-the-art simulators and practical training',
    'Global partnerships, local impact',
    'Experienced instructors with global oilfield exposure',
    'Comprehensive curriculum aligned with industry standards',
  ];

  @override
  Widget build(BuildContext context) {
    return const _BulletCard(
      icon: Icons.lightbulb_outline,
      iconColor: Color(0xFFF39C12),
      title: 'Why Choose Us?',
      bullets: _bullets,
    );
  }
}

// ─────────────────────────────────────────────
//  STAY TUNED BANNER
// ─────────────────────────────────────────────
class _StayTunedBanner extends StatelessWidget {
  const _StayTunedBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FAF4),
        border: Border.all(color: const Color(0xFF27AE60).withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('📢', style: TextStyle(fontSize: 20)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Stay Tuned! Get updates on courses, workshops, and certifications.\nLet\'s shape the future of energy, together!',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  COMPANY INFO SECTION  (About tab)
// ─────────────────────────────────────────────
class _CompanyInfoSection extends StatelessWidget {
  const _CompanyInfoSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Company Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A2B4A),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'The foundation of safe drilling operations lies in the competence of trained personnel. At Petro master academy, we believe that empowering professionals with the right knowledge is key to preventing incidents and protecting lives, assets, and the environment.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.65),
          ),
          const SizedBox(height: 12),
          const Text(
            'With a strong focus on well control, drilling operations, and safety management, we ensure that our programs address both safety and efficiency in every aspect of training.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.65),
          ),
          const SizedBox(height: 12),
          const Text(
            'Recognizing the global standards set by the International Well Control Forum (IWCF) and the International Association of Drilling Contractors (IADC), our training approach emphasizes both theoretical understanding and practical application.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.65),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppImages.loginbg1,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppImages.loginbg2,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Our goal is to ensure that every participant leaves with confidence, competence, and the ability to make the right decisions under pressure—thereby contributing to a safer, more efficient, and sustainable oil and gas industry.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.65),
          ),
          const SizedBox(height: 12),
          const Text(
            'Petromaster Academy is a premier oil & gas training institute committed to delivering high-quality technical and safety education for drilling and production professionals.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.65),
          ),
          const SizedBox(height: 12),
          const Text(
            'Our courses are designed by industry experts and delivered through modern classrooms, interactive digital modules, and advanced simulation tools to provide hands-on, practical learning.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.65),
          ),
          const SizedBox(height: 12),
          const Text(
            'Whether you are a fresher looking to enter the oilfield or an experienced professional advancing your certification, Petromaster Academy provides the knowledge, skills, and confidence to succeed in any operational environment.',
            style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.65),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  FOOTER BAR
// ─────────────────────────────────────────────
class _FooterBar extends StatelessWidget {
  const _FooterBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A2B4A),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: const Center(
        child: Text(
          '© All Rights Reserved By ALP-TS',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  REUSABLE: Info Card
// ─────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;

  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2B4A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  REUSABLE: Bullet Card
// ─────────────────────────────────────────────
class _BulletCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<String> bullets;

  const _BulletCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2B4A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...bullets.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.check_circle,
                      size: 14,
                      color: Color(0xFF27AE60),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
