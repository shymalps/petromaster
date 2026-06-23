import 'package:petromaster/core/helpers/appbarhelper.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/assets/images.dart';
import 'src/aboutussection.dart';
import 'src/contactinfo.dart';
import 'src/experiencebadge.dart';
import 'src/partnerscard.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbarhelper.pageAppbar(title: 'AboutUs', leading: true),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/exploration-and-drilling.jpg"), // or NetworkImage('https://...')
                  fit: BoxFit
                      .cover, // Use BoxFit.fill / BoxFit.contain as needed
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 300,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(45),
                    //     child: Image.network(
                    //         'https://petromasteracademy.com/assets4/images/WhatsApp%20Image%202025-01-17%20at%203.21.43%20PM.jpeg'),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: ExperienceBadge()),
                    const AboutUsSection(),
                    InstructorShowcase(),
                    const ContactInfoWidget(
                      email: 'info@petromasteracademy.com',
                      phoneNumber: '+91 8281810554',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
