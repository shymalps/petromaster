import 'package:flutter/material.dart';

import '../../../../app/config/theme/colors.dart';
import '../Aboutus/aboutus.dart';
import '../Gallary/gallery.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int selectedIndex = 0;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Aboutus(),
    Gallery(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: GNav(
          tabMargin: EdgeInsets.symmetric(vertical: 10),
          curve: Curves.bounceIn,
          backgroundColor: AppColors.primary,
          rippleColor: AppColors.primary,
          hoverColor: AppColors.primaryVariant,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.white,
          color: Colors.white,
          tabs: const [
            GButton(
              icon: Icons.info,
              text: 'About',
            ),
            GButton(
              icon: Icons.photo_album,
              text: 'Gallery',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },

          //  WaterDropNavBar(
          // bottomPadding: 10,
          // backgroundColor: AppColors.primary,
          // waterDropColor: AppColors.white,
          // selectedIndex: selectedIndex,
          // iconSize: 34,
          // inactiveIconColor: AppColors.white.withOpacity(0.7),
          // onItemSelected: (index) {
          //   setState(() {
          //     selectedIndex = index;
          //   });
          //   pageController.animateToPage(
          //     index,
          //     duration: const Duration(milliseconds: 400),
          //     curve: Curves.easeOutQuad,
          //   );
          // },
          // barItems: [
          //   BarItem(
          //     filledIcon: HugeIcons.strokeRoundedHome11,
          //     // Use rounded variants for softer look
          //     outlinedIcon: HugeIcons.strokeRoundedHome11, btext: 'Dashboard',
          //     // title: 'f',
          //   ),
          //   BarItem(
          //     filledIcon: HugeIcons.strokeRoundedBookEdit,
          //     outlinedIcon: HugeIcons.strokeRoundedBookEdit,
          //     btext: 'My Courses',
          //     // title: 'h',
          //   ),
          //   BarItem(
          //     filledIcon: HugeIcons.strokeRoundedQuiz03,
          //     outlinedIcon: HugeIcons.strokeRoundedQuiz03, btext: 'Exams',
          //     // title: 'h',
          //   ),
          //   BarItem(
          //     filledIcon: HugeIcons.strokeRoundedUserCircle,
          //     outlinedIcon: HugeIcons.strokeRoundedUserCircle, btext: 'Profile',
          //     // title: 'j',
          //   ),
          // ],
        ));
  }
}
