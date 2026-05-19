import 'package:flutter/material.dart';

import '../../../app/Di/dimensions.dart';
import '../../../app/config/theme/colors.dart';
import '../../../app/config/theme/text.dart';
import '../../res/assets/images.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;
  final Color textcolor;

  const CommonAppBar(
      {super.key,
      required this.title,
      this.centerTitle = true,
      this.actions,
      this.leading,
      this.backgroundColor = Colors.white,
      this.textcolor = AppColors.fontcolor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: AppTextHelper.mainHead(
        text: title,
        fontWeight: FontWeight.bold,
        fcolor: textcolor,
      ),

      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: 2.0,
      // leading: CustomDrawerButton(),
      actions: actions,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class Dashboardappbar extends StatelessWidget implements PreferredSizeWidget {
  const Dashboardappbar({
    super.key,
    required this.name,
    required this.email,
  });
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[700],
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FadeInImage.assetNetwork(
                placeholder: AppImages.boyavathar,
                image: 'image',
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImages.boyavathar,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const Spacer(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 5);
}

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({
    super.key,
    required this.title,
    this.leading = true, required bool leadingIcon,
  });
  final String title;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      backgroundColor: AppColors.primary,
      title: title,
      textcolor: AppColors.white,
      leading: leading
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Center(
                    child: Icon(
                      Icons.keyboard_double_arrow_left_rounded,
                      size: 20.0,
                      color: AppColors.secondary,
                    ),
                  )),
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CircleAvatar(
            backgroundColor: AppColors.white,
            child: Image.asset(
              AppImages.logo,
              width: Di.width(0.1),
              height: Di.width(0.1),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class InfoAppbar extends StatelessWidget implements PreferredSizeWidget {
  const InfoAppbar({
    super.key,
    required this.title,
    this.leading = true,
  });
  final String title;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      backgroundColor: AppColors.primary,
      title: title,
      textcolor: AppColors.white,
      leading: leading
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CircleAvatar(
                backgroundColor: AppColors.white,
                child: Image.asset(
                  AppImages.logo,
                  width: Di.width(0.1),
                  height: Di.width(0.1),
                ),
              ),
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CircleAvatar(
            backgroundColor: AppColors.white,
            child: Image.asset(
              AppImages.logo,
              width: Di.width(0.1),
              height: Di.width(0.1),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
