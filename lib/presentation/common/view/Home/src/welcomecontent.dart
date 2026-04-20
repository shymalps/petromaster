import 'package:flutter/material.dart';

class Welcomecontent extends StatelessWidget {
  const Welcomecontent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                height: 1.2,
                color: Color(0xFF2C3E50),
              ),
              children: [
                TextSpan(text: 'Our Online Class\nWill Grow '),
                TextSpan(
                  text: 'Your\n',
                  style: TextStyle(color: Color(0xFFE74C3C)),
                ),
                TextSpan(
                  text: 'Creativity',
                  style: TextStyle(color: Color(0xFFE74C3C)),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          const Text(
            'Convenience of online education, allowing learners\nto acquire new skills at their own pace and from\nany location.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF7F8C8D),
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      Icons.thumb_up,
                      color: Colors.blue,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Quality Video',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      Icons.thumb_up,
                      color: Colors.red,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Suitable Price',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
