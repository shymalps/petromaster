import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../app/config/theme/colors.dart';

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // About Us header with icon
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const HugeIcon(
                  icon:HugeIcons.strokeRoundedMortarboard02,
                  color: AppColors.secondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'About Us',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Main title
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                TextSpan(text: 'Offshore &\n',style: TextStyle(color: Colors.black),),
                TextSpan(
                  text: 'Onshore Rig Training Center',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Description text
          const Text(
            'We provide IADC Well sharp, Rig pass, Roustabout Training, Floorman Training, and Assistant Driller Training, along with training for rig employees. If you are happy with our services, please support us further by sharing information about Petromaster with your friends and family.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
