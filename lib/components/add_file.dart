import 'dart:io';
import 'package:animated_visibility/animated_visibility.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:myapp/components/action_button.dart';
import 'package:myapp/constants/k_dropdown_search.dart';
import 'package:myapp/constants/k_items_list.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/services/services.dart';

class AddFile extends StatelessWidget {
  const AddFile({super.key});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    var services = BackendServices();
    var nameCtrl = TextEditingController();
    var subjectCtrl = TextEditingController();
    myCtrl.filePicked.value = false;
    String? semester;
    File? file;
    String? filePath;
    addNte() async {
      myCtrl.showLoading.value = true;
      if (nameCtrl.text.isNotEmpty &&
          subjectCtrl.text.isNotEmpty &&
          semester != null &&
          file != null) {
        await services.addNote(
          filePath: filePath!,
          file: file!,
          name: nameCtrl.text,
          subject: subjectCtrl.text,
          semester: semester!,
        );
        Get.snackbar('Success', 'Notes added successfully');
        Navigator.pop(context);
        myCtrl.filePicked.value = false;
      } else {
        Get.snackbar('Incomplete', 'Please Complete all fields');
      }

      myCtrl.showLoading.value = false;
    }

    pickFile() async {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (pickedFile != null) {
        filePath = pickedFile.files[0].name;
        file = File(pickedFile.files[0].path!);
        myCtrl.filePicked.value = true;
      } else {
        Get.snackbar('Empty selection', 'No file picked');
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Theme.of(context).colorScheme.background,
      child: KHorizontalPadding(
        child: Column(
          children: [
            const KVerticalSpace(),
            //* File name
            TextField(
              controller: nameCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Enter file name',
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
            const KVerticalSpace(),
            //* Subject name
            TextField(
              controller: subjectCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'Enter Subject name',
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
            const KVerticalSpace(),
            //* Semester
            KSearchDropDown(
              buttonHint: 'For which semster',
              searchHint: '',
              itemsList: semesterList,
              onSelect: (val) => semester = val,
              hideSearch: true,
            ),
            const KVerticalSpace(),
            //* File picker
            DottedBorder(
              borderPadding: const EdgeInsets.all(0),
              dashPattern: const [5],
              radius: const Radius.circular(20),
              borderType: BorderType.RRect,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.5),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: 110,
                width: 200,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                // alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Obx(
                  () => myCtrl.filePicked.value
                      ? ListTile(
                          minVerticalPadding: 0,
                          title: Image.asset('images/pdf_icon.png', height: 70),
                          subtitle: Text(
                            filePath!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : IconButton(
                          onPressed: pickFile,
                          icon: const Icon(FontAwesomeIcons.paperclip),
                        ),
                ),
              ),
            ),
            const KVerticalSpace(),
            Obx(
              () => AnimatedVisibility(
                visible: myCtrl.filePicked.value,
                child: ActionButton(
                  onAction: addNte,
                  label: 'Upload Notes',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
