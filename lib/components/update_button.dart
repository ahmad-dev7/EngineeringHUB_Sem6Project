import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_dropdown_search.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/services/services.dart';

class UpdateButton extends StatelessWidget {
  final String buttonKey, title, buttonHint, buttonText;
  final List<String> itemList;
  final bool hideSearch;
  const UpdateButton(
      {super.key,
      required this.buttonKey,
      required this.title,
      required this.buttonHint,
      required this.itemList,
      required this.hideSearch,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String value = '';
        showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog.adaptive(
              title: KMyText(title),
              content: KSearchDropDown(
                buttonHint: buttonHint,
                searchHint: '',
                hideSearch: hideSearch,
                itemsList: itemList,
                onSelect: (val) => value = val,
                validate: (val) => '',
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const KMyText('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (value.isNotEmpty) {
                      await BackendServices()
                          .updateBranchSemester(value: value, key: buttonKey);
                      Get.back();
                    }
                  },
                  child: KMyText(
                    buttonText,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              ],
            );
          }),
        );
      },
      child: Chip(
        side: BorderSide.none,
        backgroundColor: Theme.of(context).colorScheme.primary,
        label: KMyText(buttonText),
        avatar: Icon(
          Icons.edit_note,
          size: 25,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
