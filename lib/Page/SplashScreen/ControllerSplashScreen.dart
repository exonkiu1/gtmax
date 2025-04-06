import 'package:get/get.dart';

class Controllersplashscreen extends GetxController {
  RxInt degreelogo = 0.obs;
  RotateLogo() async {
    for (var i = 0; i < 3; i++) {
      while (true) {
        await Future.delayed(Duration(milliseconds: (2000 / 30).toInt()));
        if (degreelogo.value < 360) {
          degreelogo.value += (360 / 30).toInt();
        } else {
          break;
        }
      }
    }
  }
}
