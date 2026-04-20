import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/Di/dimensions.dart';
import '../../../../../domain/models/notesdata_model.dart';
import '../../../shared/view/animatedlistview.dart';
import '../../../shared/view/nodatafound.dart';
import '../../viewmodel/typednotevm.dart';
import '../notes/notelist/src/listitem.dart';
import 'src/listitem.dart';
// import '../../../../shared/view/animatedlistview.dart';
// import '../../../../shared/view/nodatafound.dart';
// import '../../../viewmodel/notelistvm.dart';
// import 'src/listitem.dart';

class Typednotelist extends StatelessWidget {
  const Typednotelist({super.key});

  @override
  Widget build(BuildContext context) {
    final typenotelistVM = Get.find<TypedNotelistvm>();
    return Obx(
      () => typenotelistVM.notelist.isEmpty && typenotelistVM.isloading.value
          ? const Center(child: CircularProgressIndicator())
          : typenotelistVM.notelist.isEmpty
              ? const Emptypage()
              : Padding(
                  padding: EdgeInsets.only(
                      top: Di.screenWidth * 0.02,
                      left: Di.screenWidth * 0.02,
                      right: Di.screenWidth * 0.02),
                  child: AnimatedListView(
                    itemcount: typenotelistVM.notelist.length,
                    itemBuilder: (context, index, animation) {
                      final note = typenotelistVM.notelist[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TypedListitem(
                          id: note.tnoteId,
                          title: note.title,
                          description: note.description,
                          date: note.createdAt,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
