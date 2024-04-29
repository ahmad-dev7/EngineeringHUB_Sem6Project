import 'package:get/state_manager.dart';
import 'package:myapp/model/bots_chat.dart';
import 'package:myapp/model/user_data.dart';

class MyController extends GetxController {
  var isDarkTheme = true.obs;
  var hidePassword = true.obs;
  var showLoading = false.obs;
  var userData = UserData().obs;
  var activeScreen = 0.obs;
  var messageController = ''.obs;
  var selectedCollege = ''.obs;
  var selectedBranch = ''.obs;
  var selectedSemester = ''.obs;
  var isChatChanged = false.obs;
  var isDataLoaded = false.obs;
  Rx<String>? selectedValue;
  var isExpanded = false.obs;
  var chat = <BotsChat>[].obs;
  var filePicked = false.obs;
}
