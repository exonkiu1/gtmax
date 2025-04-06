import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import '/Core/SendOrder/OrderSms.dart';

class Controllerother extends GetxController {
  RxString TextInuiry = ''.obs;
  RxString TypeInquiry = ''.obs;
  RxString Oprator = ''.obs;
  RxString ModelCar = ''.obs;
  RxInt simcard = 0.obs;
  TextEditingController tf = TextEditingController();
  RxInt TimeCheck = 15.obs;
  RxBool ResiveSmsDev = false.obs;
  StartTimeCheck(String code) async {
    TimeCheck.value = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 1), () => TimeCheck.value += 1);
      print(TimeCheck.value);
      if (TimeCheck.value == 20 && !ResiveSmsDev.value) {
        print('start time check');
        SendSms(code, check: false);
        break;
      }
      if (ResiveSmsDev.value) {
        break;
      }
    }
  }
}
