import 'package:get/get.dart';

class Controllerkm extends GetxController {
  RxDouble spead = 0.0.obs;
  RxDouble copyvalueslider = 0.0.obs;
  RxInt CopyInput = 0.obs;
  RxInt ValueSlider = 0.obs;
  calculateSequence(int input) async {
    final x1 = 20, y1 = 6.492245;
    final x2 = 40, y2 = 25.857093;
    if (input == 0) {
      input = -3;
    }

    copyvalueslider.value = y1 + (input - x1) * (y2 - y1) / (x2 - x1);

    if (CopyInput.value != input) {
      spead.value = ValueSlider.value.toDouble();
      if (spead.value > copyvalueslider.value) {
        while (spead.value > copyvalueslider.value) {
          await Future.delayed(Duration(milliseconds: 20));
          spead.value -= 1;
        }
      } else {
        if (spead.value < copyvalueslider.value) {
          while (spead.value < copyvalueslider.value) {
            await Future.delayed(Duration(milliseconds: 20));
            spead.value += 1;
          }
        }
      }
    }
    CopyInput.value = input;
    ValueSlider.value = copyvalueslider.value.toInt();
  }

  StartCar() async {
    for (var element in ListSpead) {
      await Future.delayed(Duration(seconds: 1));
      calculateSequence(element);
    }
  }
}

List<int> ListSpead = [20, 30, 40, 50, 60, 70, 80, 50, 40, 30, 50];
