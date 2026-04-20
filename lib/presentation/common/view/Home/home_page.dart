import 'dart:async';
import 'package:petromaster/app/config/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/Di/dimensions.dart';
import '../../../../app/config/theme/colors.dart';
import '../../../../core/res/assets/images.dart';
import 'src/animatedimg.dart';
import 'src/courselist.dart';
import 'src/coursetitle.dart';
import 'src/videoplayer.dart';
import 'src/welcomecontent.dart';

class AppDetails extends StatelessWidget {
  const AppDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.homedashimg,
                ), // or NetworkImage('https://...')
                fit: BoxFit.cover, // Use BoxFit.fill / BoxFit.contain as needed
              ),
            ),
          ),
          SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.white,
                            child: Image.asset(
                              AppImages.logo,
                              width: Di.width(0.1),
                              height: Di.width(0.1),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RouteName.login);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.login_outlined,
                                    color: AppColors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                                color: Color(0xFF2C3E50),
                              ),
                              children: [
                                TextSpan(text: 'Petromaster\n'),
                                TextSpan(
                                  text: 'Academy\n',
                                  style: TextStyle(color: Color(0xFFE74C3C)),
                                ),
                                TextSpan(
                                  text: 'Right thing, Right time, Right place',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Welcomecontent(),
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          RotatingImageWidget(),
                          Center(child: AnimatedImg()),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    // const Instructersection(),
                    BrandExcellenceAlternative(),
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFFFFBF5), Color(0xFFFAEDFF)],
                            ),
                          ),
                        ),

                        SizedBox(height: 300, child: CourseGrids()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height =
        MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: AppColors.white),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(AppImages.logo, height: 100),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "WELCOME TO Petromaster LMS Platform",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: [
                        Shadow(
                          color: AppColors.primaryVariant,
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: AppColors.secondary,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: _width * 0.8,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        '"Enhance your personalised learning experience with our innovative, any time and anywhere educational application"',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: _width,
                    //     // color: AppColors.black,
                    child: const CustomCarousel(),
                  ),
                  const SizedBox(height: 10),
                  CourseGrids(),
                  // Padding(
                  //   padding: EdgeInsets.all(_width * 0.04),
                  //   child: InkWell(
                  //     onTap: () {},
                  //     child: _buildModernContainer(' Courses', _height, _width),
                  //   ),
                  // ),
                  // IntroVideo(
                  // videoUrl: 'assets/videos/Akkara Business Park.mp4',
                  // title: 'Petromaster',
                  // )
                  Padding(
                    padding: EdgeInsets.all(_width * 0.04),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_fill,
                          size: 60,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Alternative version with even more modern styling
  Widget _buildModernContainer(
    String text,
    double height,
    double width, {
    VoidCallback? onTap,
    IconData? leadingIcon,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: height * 0.09,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 1,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Optional leading icon
                      if (leadingIcon != null) ...[
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            leadingIcon,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],

                      // Text with improved typography
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Enhanced arrow with ripple effect
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondary.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.white,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({Key? key}) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late final PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentPage = 0;

  final List<String> bgImg = [
    AppImages.loginbg1,
    AppImages.loginbg2,
    AppImages.loginbg3,
    AppImages.loginbg4,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % bgImg.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: bgImg.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = (_pageController.page! - index).abs();
                    value = (1 - value).clamp(0.0, 1.0);
                  }
                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) * 200,
                      width: double.infinity,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(bgImg[index], fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(bgImg.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentPage == index ? 12 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: _currentPage == index ? AppColors.primary : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
