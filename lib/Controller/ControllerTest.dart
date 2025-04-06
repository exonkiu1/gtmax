import 'package:get/get.dart';

class Controllertest extends GetxController {
  RxDouble valueslider = 0.0.obs;
  RxDouble copyvalueslider = 0.0.obs;
  calculateSequence(int input) async {
    final x1 = 20, y1 = 6.492245;
    final x2 = 40, y2 = 25.857093;
    copyvalueslider.value = y1 + (input - x1) * (y2 - y1) / (x2 - x1);

    if (valueslider.value >= copyvalueslider.value) {
      while (valueslider.value >= copyvalueslider.value) {
        await Future.delayed(Duration(milliseconds: 20));
        valueslider.value -= 1;
      }
    } else {
      if (valueslider.value <= copyvalueslider.value) {
        while (valueslider.value <= copyvalueslider.value) {
          await Future.delayed(Duration(milliseconds: 20));
          valueslider.value += 1;
        }
      }
    }
  }

  StartCar() async {
    for (var element in ListSpead) {
      await Future.delayed(Duration(seconds: 1));
      calculateSequence(element);
    }
  }
}

List<int> ListSpead = [20, 30, 40, 50, 60, 70, 80, 50, 40, 30, 50];
