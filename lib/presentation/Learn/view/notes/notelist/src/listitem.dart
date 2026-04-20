import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
// import 'package:oyster_lms/app/config/theme/text.dart';
// import 'package:oyster_lms/core/helpers/dialougehelper.dart';

import '../../../../../../app/Di/dimensions.dart';
import '../../../../../../app/config/routes/route_name.dart';
import '../../../../../../app/config/theme/text.dart';
import '../../../../../../core/helpers/dialougehelper.dart';
import '../../../../viewmodel/notelistvm.dart';

// import 'package:iconsax/iconsax.dart';
enum Documenttype { pdf, img, doc, oth }

class AttractivePdfListItem extends StatefulWidget {
  final String id;
  final String title;
  final String? subtitle;
  final List<String> fileurl;
  final String fileSize;
  final String? date;
  final bool isFavorite;
  final bool isfolder;
  // final VoidCallback onTap;
  final VoidCallback? onMorePressed;
  final VoidCallback? onFavoritePressed;

  const AttractivePdfListItem({
    required this.title,
    this.subtitle,
    required this.fileSize,
    this.date,
    this.isFavorite = false,
    // required this.onTap,
    this.onMorePressed,
    this.onFavoritePressed,
    super.key,
    required this.isfolder,
    required this.fileurl,
    required this.id,
  });

  @override
  State<AttractivePdfListItem> createState() => _AttractivePdfListItemState();
}

class _AttractivePdfListItemState extends State<AttractivePdfListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final noteVM = Get.find<Notelistvm>();
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
        onTap: () async {
          await noteVM.noteseen(widget.id);
          if (widget.isfolder) {
            showModalBottomSheet(
              context: context,
              builder: (context) => _buildBottomSheet(context, widget.fileurl),
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
            );
          } else {
            switch (_gettype(widget.fileurl[0])) {
              case Documenttype.pdf:
                Get.toNamed(RouteName.pdfview, arguments: widget.fileurl[0]);
                break;
              case Documenttype.img:
                Get.toNamed(RouteName.imgview, arguments: widget.fileurl[0]);
                break;
              default:
                Dialougehelper.error(context, 'Error', 'Unsupported file type');
                break;
            }
          }
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
                  child: widget.isfolder
                      ? HugeIcon(
                         icon: HugeIcons.strokeRoundedFolder02 ,
                          size: 28,
                          color: Colors.white,
                        )
                      : HugeIcon(
                          icon: getIcon(widget.fileurl[0]),
                          // HugeIcons.strokeRoundedPdf01,
                          size: 28,
                          color: Colors.white,
                        )),
              // :
              // _getIcon(widget.fileurl)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: AppTextHelper.button(text: widget.title)),
                        if (widget.onFavoritePressed != null)
                          IconButton(
                            icon: HugeIcon(
                              icon: widget.isFavorite
                                  ? HugeIcons.strokeRoundedStar
                                  : HugeIcons.strokeRoundedStar,
                              color: widget.isFavorite
                                  ? Colors.red
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.4),
                              size: 20,
                            ),
                            onPressed: widget.onFavoritePressed,
                            splashRadius: 20,
                          ),
                      ],
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        // Icon(
                        //   Icons.download,
                        //   size: 14,
                        //   color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        // ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.fileSize} MB',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                        ),
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
                            widget.date!,
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
              // if (widget.onMorePressed != null) ...[
              //   const SizedBox(width: 8),
              //   IconButton(
              //     icon: Icon(
              //       Icons.more,
              //       size: 22,
              //       color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              //     ),
              //     onPressed: widget.onMorePressed,
              //     splashRadius: 20,
              //   ),
              // ],
            ],
          ),
        ),
      ),
    );
  }

   dynamic getIcon(String fileurl) {
    _gettype(fileurl);
    switch (_gettype(fileurl)) {
      case Documenttype.pdf:
        return HugeIcons.strokeRoundedPdf02;
      case Documenttype.img:
        return HugeIcons.strokeRoundedImage03;
      default:
        return HugeIcons.strokeRoundedFileNotFound;
    }
  }

  Documenttype _gettype(String fileurl) {
    String fileName = fileurl.split('/').last;
    final fileExtension = fileName.split('.').last.toLowerCase();
    if (fileExtension == 'pdf') {
      return Documenttype.pdf;
    } else if (fileExtension == 'jpg' ||
        fileExtension == 'jpeg' ||
        fileExtension == 'png') {
      return Documenttype.img;
    } else {
      return Documenttype.oth;
    }
  }

  Widget _buildBottomSheet(BuildContext context, List<String> files) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(
            height: Di.screenWidth,
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return _buildOption(
                    getIcon(widget.fileurl[index]), 'Demo ${index + 1}', () {
                  switch (_gettype(widget.fileurl[index])) {
                    case Documenttype.pdf:
                      Get.toNamed(RouteName.pdfview,
                          arguments: widget.fileurl[index]);
                      break;
                    case Documenttype.img:
                      Get.toNamed(RouteName.imgview,
                          arguments: widget.fileurl[index]);
                      break;
                    default:
                      Dialougehelper.error(
                          context, 'Error', 'Unsupported file type');
                      break;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(dynamic icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: HugeIcon(icon: icon, color: Colors.indigo),
      title: Text(text, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
