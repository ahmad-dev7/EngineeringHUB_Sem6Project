import 'package:animated_visibility/animated_visibility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/action_button.dart';
import 'package:myapp/constants/k_dropdown_search.dart';
import 'package:myapp/constants/k_dropdown_wrapper.dart';
import 'package:myapp/constants/k_items_list.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/controller/animation_controller.dart';

class ChatSwitcher extends StatelessWidget {
  const ChatSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedCollege;
    String? selectedBranch;
    String? selectedSemester;
    var myCtrl = Get.put(MyController());
    var myAnimationCtrl = Get.put(MyAnimationController());
    changeChat() async {
      myCtrl.showLoading.toggle();
      await Future.delayed(const Duration(milliseconds: 500));
      if (selectedCollege != null) {
        myCtrl.selectedCollege.value = selectedCollege!;
        myCtrl.isExpanded.value = true;
        myCtrl.isChatChanged.value = true;
      }
      if (selectedBranch != null) {
        myCtrl.selectedBranch.value = selectedBranch!;
        myCtrl.isExpanded.value = true;
        myCtrl.isChatChanged.value = true;
      }
      if (selectedSemester != null) {
        myCtrl.selectedSemester.value = selectedSemester!;
        myCtrl.isExpanded.value = true;
        myCtrl.isChatChanged.value = true;
      }
      if (selectedCollege == null &&
          selectedBranch == null &&
          selectedBranch == null) {
        Get.snackbar(
          'Empty Selection',
          'You are already in the following chat',
        );
      }
      myCtrl.showLoading.toggle();
    }

    goToDefault() async {
      myCtrl.showLoading.toggle();
      myCtrl.selectedCollege.value = myCtrl.userData.value.college;
      myCtrl.selectedBranch.value = myCtrl.userData.value.branch;
      myCtrl.selectedSemester.value = myCtrl.userData.value.semester;
      await Future.delayed(const Duration(milliseconds: 300));
      myCtrl.showLoading.toggle();
      myCtrl.isChatChanged.toggle();
      myCtrl.update();
    }

    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      width: double.maxFinite,
      duration: const Duration(milliseconds: 1500),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 10),
            spreadRadius: 5,
            blurRadius: 10,
            color: Color(0x17000000),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: KDropdownWrapper(
                    child: Obx(
                      () => KSearchDropDown(
                        buttonHint: myCtrl.selectedCollege.value,
                        searchHint: 'Search College',
                        itemsList: collegeList,
                        selectedValue: myCtrl.selectedCollege.value ==
                                myCtrl.userData.value.college
                            ? null
                            : myCtrl.selectedCollege.value,
                        onSelect: (val) => selectedCollege = val,
                        changeBorder: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    myCtrl.isExpanded.toggle();
                    if (!myCtrl.isExpanded.value) {
                      myAnimationCtrl.controller.reverse();
                    } else {
                      myAnimationCtrl.controller.forward();
                    }
                  },
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.list_view,
                    progress: myAnimationCtrl.animation,
                    semanticLabel: 'Show menu',
                  ),
                )
              ],
            ),
            Obx(
              () => AnimatedVisibility(
                visible: myCtrl.isExpanded.value,
                enter: expandVertically(alignment: -1),
                exit: shrinkVertically(alignment: -1),
                child: Column(
                  children: [
                    const KVerticalSpace(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: KDropdownWrapper(
                            child: Obx(
                              () => KSearchDropDown(
                                buttonHint: myCtrl.selectedBranch.value,
                                searchHint: 'Search branch',
                                selectedValue: myCtrl.selectedBranch.value ==
                                        myCtrl.userData.value.branch
                                    ? null
                                    : myCtrl.selectedBranch.value,
                                itemsList: branchList,
                                onSelect: (val) => selectedBranch = val,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: KDropdownWrapper(
                            child: Obx(
                              () => KSearchDropDown(
                                buttonHint: myCtrl.selectedSemester.value,
                                searchHint: '',
                                hideSearch: true,
                                selectedValue: myCtrl.selectedSemester.value ==
                                        myCtrl.userData.value.semester
                                    ? null
                                    : myCtrl.selectedSemester.value,
                                itemsList: semesterList,
                                onSelect: (val) => selectedSemester = val,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const KVerticalSpace(height: 10),
                    ActionButton(
                      onAction: () {
                        myCtrl.isChatChanged.value
                            ? goToDefault()
                            : changeChat();
                      },
                      label: myCtrl.isChatChanged.value
                          ? 'Go to my chat'
                          : 'Enter this chat',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
