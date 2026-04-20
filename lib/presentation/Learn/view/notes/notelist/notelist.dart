import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../app/Di/dimensions.dart';
import '../../../../../domain/models/notesdata_model.dart';
import '../../../../shared/view/animatedlistview.dart';
import '../../../../shared/view/nodatafound.dart';
import '../../../viewmodel/notelistvm.dart';
import 'src/listitem.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    final notelistVM = Get.find<Notelistvm>();
    return Obx(
      () => notelistVM.notelist.isEmpty && notelistVM.isloading.value
          ? const Center(child: CircularProgressIndicator())
          : notelistVM.notelist.isEmpty
              ? const Emptypage()
              : Padding(
                  padding: EdgeInsets.only(
                      top: Di.screenWidth * 0.02,
                      left: Di.screenWidth * 0.02,
                      right: Di.screenWidth * 0.02),
                  child: AnimatedListView(
                    itemcount: notelistVM.notelist.length,
                    // videoVM.videoList.length,
                    itemBuilder: (context, index, animation) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: FadeTransition(
                          opacity:
                              animation.drive(CurveTween(curve: Curves.easeIn)),
                          child: AttractivePdfListItem(
                            id: notelistVM.notelist[index].notesId,
                            fileurl: notelistVM.notelist[index].fileName,
                            title: notelistVM.notelist[index].title,
                            subtitle: notelistVM.notelist[index].descp,
                            fileSize: notelistVM.notelist[index].size ?? '',
                            date: timestampToDate(int.parse(
                                notelistVM.notelist[index].createdAt)),
                            isFavorite: false,
                            // onTap: () {

                            // },
                            // => openPdfViewer(file),
                            // onFavoritePressed: () {},
                            // => toggleFavorite(file),
                            // onMorePressed: () {},
                            isfolder:
                                //  true,
                                notelistVM.notelist[index].fileName.length > 1
                                    ? true
                                    : false,
                            // => showOptionsMenu(file),
                          ),
                        ),
                      );
                    },
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
