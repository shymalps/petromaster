import 'package:flutter/material.dart';

import '../../../../../app/config/theme/colors.dart';

class InstructorShowcase extends StatelessWidget {
  // Sample instructor data - replace with your actual data
  final List<Instructor> instructors = [
    Instructor(
      name: 'JINNY JOSE AKKARA ',
      specialty: 'COSL Toolpusher',
      imageUrl:
          'https://petromasteracademy.com/assets4/images/WhatsApp%20Image%202025-01-06%20at%2010.21.16%20AM.jpeg',
      position: 'CHAIRMAN & INSTRUCTOR',
    ),
    Instructor(
      name: 'JOHN GEORGE',
      specialty: 'Saipem Offshore Driller',
      imageUrl: 'https://petromasteracademy.com/assets4/images/john%20george.jpg',
      position: 'GENERAL MANAGER',
    ),
    Instructor(
      name: 'CHEKSON N CHERIYAN',
      specialty: 'COSL Toolpusher',
      imageUrl:
          'https://petromasteracademy.com/assets4/images/WhatsApp%20Image%202025-01-18%20at%2011.27.57%20PM.jpeg',
      position: 'DIRECTOR',
    ),
    Instructor(
      name: 'CHERSON K CHERIYAN',
      // specialty: 'NDSC Rig Maintainance Supervisor',
      imageUrl: 'https://petromasteracademy.com/assets4/images/Cherson%20Sir.jpg',
      position: 'IRECTOR & INSTRUCTOR',
    ),
    Instructor(
      name: 'JUSTIN K GEORGE',
      // specialty: 'NDSC Rig Maintainance Supervisor',
      imageUrl: 'https://petromasteracademy.com/assets4/images/Justin%20Sir.jpg',
      position: 'DIRECTOR & INSTRUCTOR',
    ),
    Instructor(
      name: 'SHANKARBHAI CHAUDHARY',
      // specialty: 'NDSC Rig Maintainance Supervisor',
      imageUrl:
          'https://petromasteracademy.com/assets4/images/WhatsApp%20Image%202025-08-12%20at%209.51.21%20AM.jpeg',
      position: 'IRECTOR & INSTRUCTOR',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primary, Colors.transparent],
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Meet Our Expert Team',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Learn from industry professionals with years of experience',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: instructors.length,
                    itemBuilder: (context, index) {
                      return InstructorCard(instructor: instructors[index]);
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          // Instructors Row
          // Container(
          //   height: 320,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     itemCount: instructors.length,
          //     itemBuilder: (context, index) {
          //       return InstructorCard(instructor: instructors[index]);
          //     },
          //   ),
          // ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class InstructorCard extends StatefulWidget {
  final Instructor instructor;

  const InstructorCard({Key? key, required this.instructor}) : super(key: key);

  @override
  _InstructorCardState createState() => _InstructorCardState();
}

class _InstructorCardState extends State<InstructorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle instructor card tap
        _showInstructorDetails(context);
      },
      onTapDown: (_) {
        setState(() => _isHovered = true);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      onTapCancel: () {
        setState(() => _isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 220,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                    blurRadius: _isHovered ? 20 : 15,
                    offset: Offset(0, _isHovered ? 8 : 5),
                  ),
                ],
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown
                ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                
                    // Profile Image
                    Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.primary],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.instructor.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                
                    SizedBox(height: 16),
                
                    // Name
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.instructor.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                
                    SizedBox(height: 8),
                    Text(
                      widget.instructor.specialty ?? '',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Specialty
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        widget.instructor.position,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                
                    SizedBox(height: 12),
                
                    // Experience
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Icon(
                    //       Icons.star,
                    //       size: 16,
                    //       color: Colors.amber[600],
                    //     ),
                    //     SizedBox(width: 4),
                    //     Text(
                    //       widget.instructor.experience,
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Colors.grey[600],
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                
                    // Spacer(),
                
                    // View Profile Button
                  ],
                ),
              ),
           
            ),
          );
        },
      ),
    );
  }

  void _showInstructorDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.instructor.imageUrl),
              ),
              SizedBox(height: 16),
              Text(
                widget.instructor.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.instructor.specialty ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.indigo[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              // Text(
              //   'Experience: ${widget.instructor.experience}',
              //   style: TextStyle(
              //     fontSize: 14,
              //     color: Colors.grey[600],
              //   ),
              // ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

// Instructor Model
class Instructor {
  final String name;
  final String? specialty;
  final String position;
  final String imageUrl;

  Instructor(
      {required this.name,
      this.specialty,
      required this.imageUrl,
      required this.position});
}
