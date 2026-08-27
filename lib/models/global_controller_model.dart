import 'package:get/get.dart';

class GlobalControllerModel extends GetxController {
  var data = ''.obs;

  void updateData(String urlText) {
    data.value = urlText;
  }
}
