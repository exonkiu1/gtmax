import 'package:get/get.dart';

class Controlleroptions extends GetxController {
  @override
  void onInit() {
    RotateMonth();
    // TODO: implement onInit
    super.onInit();
  }

  RxInt DegreeMonth = 0.obs;
  RotateMonth() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      if (DegreeMonth.value != 360) {
        DegreeMonth.value += 1;
      } else {
        DegreeMonth.value = 0;
      }
    }
  }
}
