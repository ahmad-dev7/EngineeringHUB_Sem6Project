import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/notes_pdf_viewer.dart';
import 'package:myapp/constants/k_my_page_container.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/notes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentNotes extends StatelessWidget {
  final Stream? streamQuery;
  const DocumentNotes({super.key, this.streamQuery});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: streamQuery ??
            FirebaseFirestore.instance
                .collection('notes')
                .where('branch', isEqualTo: myCtrl.userData.value.branch)
                .where('semester', isEqualTo: myCtrl.userData.value.semester)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SingleChildScrollView();
          }
          if (snapshot.hasData) {
            var notes = <Notes>[];
            var documents = snapshot.data?.docs.toList();
            for (var document in documents!) {
              var note = document.data();
              notes.add(Notes.fromJson(note));
            }
            return KMyPageContainer(
              child: DynamicHeightGridView(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemCount: notes.length,
                crossAxisCount: ResponsiveBreakpoints.of(context).isMobile
                    ? 2
                    : ResponsiveBreakpoints.of(context).isTablet
                        ? 3
                        : 4,
                builder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      kIsWeb
                          ? launchUrl(Uri.parse(notes[index].url!))
                          : Get.to(
                              NotesPDFViewer(
                                url: notes[index].url!,
                                title: notes[index].name!,
                              ),
                            );
                    },
                    child: Card(
                      elevation: 5,
                      color: Theme.of(context).colorScheme.primary,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Image.asset('images/pdf_icon.png', height: 75),
                          ListTile(
                            minVerticalPadding: 0,
                            title: KMyText(
                              notes[index].name!,
                              size: 12,
                              weight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: KMyText(
                              notes[index].subject!,
                              size: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }
          return const Center(child: KMyText('No notes available yet'));
        },
      ),
    );
  }
}
