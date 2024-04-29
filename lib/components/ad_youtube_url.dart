import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myapp/components/action_button.dart';
import 'package:myapp/constants/k_dropdown_search.dart';
import 'package:myapp/constants/k_items_list.dart';
import 'package:myapp/constants/k_my_page_container.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/services/services.dart';

class AddYouTubeUrl extends StatelessWidget {
  const AddYouTubeUrl({super.key});

  @override
  Widget build(BuildContext context) {
    var urlCtrl = TextEditingController();
    var subjectCtrl = TextEditingController();
    var semester = '';
    var services = BackendServices();
    var myCtrl = Get.put(MyController());
    var copiedText = '';
    getClipboardData() async {
      var data = await Clipboard.getData(Clipboard.kTextPlain);
      copiedText = data?.text ?? '';
      return copiedText.contains('http');
    }

    getClipboardData();
    onAddUrl() async {
      myCtrl.showLoading.toggle();
      if (urlCtrl.text.isNotEmpty && subjectCtrl.text.isNotEmpty) {
        await services.addYouTubeUrl(
            url: urlCtrl.text, semester: semester, subject: subjectCtrl.text);
        Get.snackbar('Successful', 'YouTube url added successfully');
        Navigator.pop(context);
      } else {
        Get.snackbar('Incomplete', 'Please fill all input fields');
      }
      myCtrl.showLoading.toggle();
    }

    return KMyPageContainer(
      child: Column(
        children: [
          const KVerticalSpace(),
          TextField(
            controller: urlCtrl,
            decoration: InputDecoration(
              hintText: 'Enter YouTube video/playlist url',
              contentPadding: const EdgeInsets.only(left: 10),
              suffixIcon: InkWell(
                onTap: () => urlCtrl.text = copiedText,
                child: Icon(
                  Icons.paste,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          const KVerticalSpace(),
          TextField(
            controller: subjectCtrl,
            decoration: const InputDecoration(
              hintText: 'Subject name',
              contentPadding: EdgeInsets.only(left: 10),
            ),
          ),
          const KVerticalSpace(),
          KSearchDropDown(
            buttonHint: 'For which semester',
            searchHint: '',
            itemsList: semesterList,
            onSelect: (val) => semester = val,
            hideSearch: true,
          ),
          const KVerticalSpace(),
          ActionButton(
            onAction: onAddUrl,
            label: 'Add Url',
          )
        ],
      ),
    );
  }
}
