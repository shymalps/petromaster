// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:oyster_lms/app/config/theme/colors.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';
// import 'package:oyster_lms/core/res/assets/images.dart';

// import '../../../app/Di/dimensions.dart';

// class CustomFlutterErrorWidget extends StatelessWidget {
//   final FlutterErrorDetails? errorDetails;
//   const CustomFlutterErrorWidget({
//     super.key,
//     this.errorDetails,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 AppTextHelper.subHead(
//                     text: 'went_wrong'.tr,
//                     textAlign: TextAlign.center,
//                     fontWeight: FontWeight.bold,
//                     fcolor: AppColors.primary),
//                 SvgPicture.asset(height: Di.screenWidth*0.75,
//                   AppImages.errorimg,
//                 ),
//                 // const SizedBox(height: 20.0),
//                 const SizedBox(height: 12.0),
//                 AppTextHelper.caption(
//                     textAlign: TextAlign.center, text: 'went_wrong_desc'.tr),
//                 const SizedBox(height: 30.0),
// //?======> Show error details only in debug mode (kDebugMode is Flutter's flag)
//                 if (kDebugMode && errorDetails != null) ...[
//                   const SizedBox(height: 20.0),
//                  const  Text(
//                     'Error Details (Debug Only):',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Text(
//                         errorDetails.toString(),
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           color: Colors.red.shade800,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Placeholder Home Page - Replace with your actual home screen implementation


