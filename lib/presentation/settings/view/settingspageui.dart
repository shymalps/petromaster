import 'dart:io';

import 'package:petromaster/presentation/common/controller/studentresponcecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:petromaster/app/config/theme/text.dart';
import 'package:petromaster/core/helpers/appbarhelper.dart';
import 'package:petromaster/presentation/common/view/Aboutus/aboutus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../AuthPref.dart';
import '../../../app/Di/dimensions.dart';
import '../../../app/config/routes/route_name.dart';
import '../../../app/config/theme/colors.dart';
import '../../../core/helpers/dialougehelper.dart';
import '../../../core/res/assets/images.dart';
import '../../common/controller/profile_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileVM = Get.find<Profilevm>();
    // final response = StudentResponse.fromJson(profileVM.profileData!.toJson());
    // print(response.data?[0].name);
    // print(response.data?[0].seenNote);
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: 'Settings', leading: false),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const SizedBox(),
            backgroundColor: AppColors.primary,
            collapsedHeight: Di.screenWidth * 0.2,
            expandedHeight: Di.screenWidth * 0.45,
            floating: true,
            pinned: true,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: Di.screenWidth * 0.1,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeInImage.assetNetwork(
                          placeholder: AppImages.boyavathar,
                          image: profileVM.profileData!.profImg ?? '',
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
                    SizedBox(height: Di.screenWidth * 0.02),
                    AppTextHelper.mainHead(
                      text: profileVM.profileData!.name,
                      fcolor: Colors.white,
                    ),
                    SizedBox(height: Di.screenWidth * 0.01),
                    AppTextHelper.subHead(
                      text: profileVM.profileData!.email,
                      fcolor: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    // ListTile(
                    //   leading: const Icon(HugeIcons.strokeRoundedCrown),
                    //   title: RichText(
                    //     text: TextSpan(
                    //       style: DefaultTextStyle.of(context).style,
                    //       children: <TextSpan>[
                    //         const TextSpan(
                    //           text: 'Subscription expires in ',
                    //           style: TextStyle(color: Colors.black),
                    //         ),
                    //         TextSpan(
                    //           text: profileVM.timestampToDate(
                    //               profileVM.profileData!.expireDate),
                    //           style: const TextStyle(color: Colors.grey),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   trailing: Icon(
                    //     Icons.chevron_right,
                    //     color: Colors.grey.shade500,
                    //   ),
                    //   onTap: () {},
                    // ),
                    Divider(height: 1, color: Colors.grey.shade300),
                    ListTile(
                      leading: const HugeIcon(
                        icon: HugeIcons.strokeRoundedDocumentValidation,
                      ),
                      title: const Text('Data privacy terms'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade500,
                      ),
                      onTap: () async {
                        Uri url = Uri.parse(
                          "https://lms.petromasteracademy.com/privacy_policy",
                        );
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.inAppWebView,
                        )) {
                          throw Exception('Could not launch $url');
                        }
                      },
                    ),
                    // Divider(
                    //   height: 1,
                    //   color: Colors.grey.shade300,
                    // ),
                    // ListTile(
                    //   leading: const HugeIcon(
                    //     icon: HugeIcons.strokeRoundedGlobe02,
                    //   ),
                    //   title: const Text('Clear Cache'),
                    //   trailing: Icon(
                    //     Icons.chevron_right,
                    //     color: Colors.grey.shade500,
                    //   ),
                    //   onTap: () {
                    //     // getAppCacheSizeInMB().then((size) async {
                    //     //   if (size > 0) {
                    //     //     final condition = await Dialougehelper.confirmation(
                    //     //       Get.context,
                    //     //       'App cache size',
                    //     //       'App cache size: ${size.toStringAsFixed(2)} MB. Do you want to free up space?',
                    //     //     );
                    //     //     if (condition) {
                    //     //       clearAppCache();
                    //     //     }
                    //     //     // Dialougehelper.warning(
                    //     //     //   Get.context,
                    //     //     //   'App cache size',
                    //     //     //   'App cache size: ${size.toStringAsFixed(2)} MB. Do you want to free up space?',
                    //     //     // );
                    //     //   } else {
                    //     //     Dialougehelper.info(Get.context, '',
                    //     //         'your app is already optimized');
                    //     //   }
                    //     // });
                    //     // Navigate to terms and conditions screen
                    //   },
                    // ),
                    Divider(height: 1, color: Colors.grey.shade300),
                    ListTile(
                      leading: const HugeIcon(icon: HugeIcons.strokeRoundedId),
                      title: const Text('View ID Card'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade500,
                      ),
                      onTap: () async {
                        Get.toNamed(
                          RouteName.idcardview,
                          arguments: profileVM.profileData,
                        );
                      },
                    ),
                    Divider(height: 1, color: Colors.grey.shade300),
                    ListTile(
                      leading: const HugeIcon(
                        icon: HugeIcons.strokeRoundedGroupItems,
                      ),
                      title: const Text('Student Details'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade500,
                      ),
                      onTap: () async {
                        final studentCtrl =
                            Get.find<GetStudentResponseController>();
                        // Start loading
                        studentCtrl.isloading.value = true;

                        // await studentCtrl.studentData;
                        await studentCtrl.getStudentById(
                          profileVM.profileData!.userId.toString(),
                        );

                        studentCtrl.isloading.value = false;

                        if (studentCtrl.studentData != null) {
                          Get.toNamed(
                            RouteName.studentDetailsView,

                            ///(call the popup screen)
                            arguments: profileVM.profileData!.profImg,
                          );
                        } else {
                          Dialougehelper.warning(
                            context,
                            'Error',
                            'Unable to fetch student details',
                          );
                        }
                      },
                    ),
                    Divider(height: 1, color: Colors.grey.shade300),
                    ListTile(
                      leading: const HugeIcon(
                        icon: HugeIcons.strokeRoundedFolderDetails,
                      ),
                      title: const Text('About Us'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade500,
                      ),
                      onTap: () async {
                        Get.to(() => const Aboutus());
                      },
                    ),
                    Divider(height: 1, color: Colors.grey.shade300),
                    ListTile(
                      leading: const HugeIcon(
                        icon: HugeIcons.strokeRoundedLogout03,
                      ),
                      title: const Text('Log Out'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade500,
                      ),
                      onTap: () async {
                        await AuthPreferences.logout();
                        Get.offAllNamed(RouteName.appnav);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Future<double> getAppCacheSizeInMB() async {
//   try {
//     final tempDir = await getTemporaryDirectory();
//     final sizeInBytes = await _getTotalSizeOfFilesInDir(tempDir);
//     return sizeInBytes / (1024 * 1024); // Convert to MB
//   } catch (e) {
//     print('Error calculating cache size: $e');
//     return 0.0;
//   }
// }

Future<int> _getTotalSizeOfFilesInDir(FileSystemEntity file) async {
  if (file is File) {
    return await file.length();
  }
  if (file is Directory) {
    final children = file.listSync();
    int total = 0;
    for (final child in children) {
      total += await _getTotalSizeOfFilesInDir(child);
    }
    return total;
  }
  return 0;
}

// Future<void> clearAppCache() async {
//   try {
//     final tempDir = await getTemporaryDirectory();
//     await _deleteFilesInDirectory(tempDir);
//     // You might also want to clear other caches like Hive or shared preferences if needed
//   } catch (e) {
//     print('Error clearing cache: $e');
//     rethrow; // You can handle this error in your UI
//   }
// }

Future<void> _deleteFilesInDirectory(FileSystemEntity file) async {
  if (file is File) {
    try {
      await file.delete();
    } catch (e) {
      print('Error deleting file ${file.path}: $e');
    }
  }
  if (file is Directory) {
    final children = file.listSync();
    for (final child in children) {
      await _deleteFilesInDirectory(child);
    }
    try {
      await file.delete(); // Delete the directory itself if empty
    } catch (e) {
      // Directory might not be empty if some files couldn't be deleted
      print('Error deleting directory ${file.path}: $e');
    }
  }
}
