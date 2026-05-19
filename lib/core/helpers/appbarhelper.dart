// import 'package:oyster_lms/core/utils/appbar/appbartypes.dart';

import '../utils/appbar/appbartypes.dart';

class Appbarhelper {
  static PageAppBar pageAppbar({
    required String title,
    bool leading = true,
    bool leadingIcon = true,
  }) {
    return PageAppBar(
      title: title,
      leading: leading,
      leadingIcon: leadingIcon,
    );
  }

  static Dashboardappbar dashboardAppbar(String name, email) {
    return Dashboardappbar(
      name: name,
      email: email,
    );
  }
}

  // static InfoAppbar infoappbar({
  //   required String title,
  //   bool leading = true,
  // }) {
  //   return InfoAppbar(title: title, leading: leading);
  // }

