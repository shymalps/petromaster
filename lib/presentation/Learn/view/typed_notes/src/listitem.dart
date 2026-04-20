import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';
// import 'package:oyster_lms/core/helpers/dialougehelper.dart';

import '../../../../../../app/config/routes/route_name.dart';
import '../../../../../../app/config/theme/text.dart';
// import '../../../../viewmodel/notelistvm.dart';

// import 'package:iconsax/iconsax.dart';

class TypedListitem extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String? date;
  final VoidCallback? onMorePressed;

  const TypedListitem({
    required this.title,
    required this.description,
    this.date,
    this.onMorePressed,
    super.key,
    required this.id,
  });

  @override
  State<TypedListitem> createState() => _TypedListitemState();
}

class _TypedListitemState extends State<TypedListitem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // final noteVM = Get.find<Notelistvm>();
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).dividerColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Get.toNamed(RouteName.htmlview, arguments: {
            'title': widget.title,
            'content': widget.description
          });
          // title: widget.title, content: widget.description
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3),
                        blurRadius: _isHovered ? 8 : 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: const HugeIcon(
                    icon: HugeIcons.strokeRoundedNote02,
                    size: 28,
                    color: Colors.white,
                  )),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: AppTextHelper.button(text: widget.title)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const SizedBox(width: 4),
              
                        const SizedBox(width: 12),
                        if (widget.date != null) ...[
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedCalendar03,
                            size: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            timestampToDate(int.parse(widget.date!)),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String timestampToDate(int timestamp, {String format = 'dd-MM-yyyy'}) {
    // Convert seconds to milliseconds (if timestamp is in seconds)
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    // Format the DateTime object
    return DateFormat(format).format(dateTime);
  }
}
