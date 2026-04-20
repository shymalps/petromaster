import 'package:flutter/material.dart';

class ExperienceBadge extends StatelessWidget {
  final String years;
  final String subtitle;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color shadowColor;

  const ExperienceBadge({
    Key? key,
    this.years = '25+',
    this.subtitle = 'Years\nof experience',
    this.backgroundColor = Colors.white,
    this.textColor = const Color(0xFF2B5CE6),
    this.iconColor = const Color(0xFFFFB800),
    this.shadowColor = const Color(0x1A2B5CE6),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lightbulb Icon
          Container(
              width: 40,
              height: 40,
              child: Image.asset(
                  'assets/images/applogo.png')),
          const SizedBox(width: 16),
          // Text Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                years,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
