import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerHistory.dart';
import '/Controller/ControllerHomepage.dart';
import '/Controller/ControllerInfo.dart';
import '/Controller/ControllerInternet.dart';
import '/Controller/ControllerOther.dart';
import '/Core/Widget/KM/ControllerKm.dart';
import '/Core/Widget/Map/ControllerMap.dart';
import '../Core/SendOrder/OrderSms.dart';

class Controllermaponline extends GetxController {
  @override
  void onInit() {
    GetMapOnline();
    // TODO: implement onInit
    super.onInit();
  }

  RxBool Maponline = true.obs;
  RxString TextStateInternet = ''.obs;
  RxInt TimeE222 = 1.obs;
  RxBool sendsmsloc = false.obs;
  RxInt CounterRepeat = 0.obs;
  GetMapOnline() async {
    await Future.delayed(Duration(seconds: 1));
    final context = Get.context;
    Get.find<Controllerhomepage>().LightGuideCar();
    String copyval = '';
    while (true) {
      await Future.delayed(Duration(milliseconds: 400));
      String value =
          'http://h5q.ir/api/webapi/GetClientG?id=${Get.find<Controllerinternet>().Id.value}${Get.find<Controllerinternet>().Pass.value}qerr1';

      if (Get.find<Controllerinternet>().Id.value.length > 2 &&
          Get.find<Controllerinternet>().Pass.value.length > 2 &&
          Maponline.value) {
        var dio = Dio();
        try {
          var response = await dio.request(
            value,
            options: Options(
              method: 'GET',
            ),
          );
          if (response.statusCode == 200) {
            String val = '${json.encode(response.data)}'.replaceAll('"', '');

            print(val);
            if (val == copyval) {
              CounterRepeat.value += 1;
            } else {
              copyval = val;
              CounterRepeat.value = 0;
            }
            if (CounterRepeat.value > 30 && val.length > 10) {
              print(CounterRepeat.value);
              print('no internet');
              CounterRepeat.value = 0;
              if (!sendsmsloc.value) {
                sendsmsloc.value = true;
                DirectInquiry(() => Get.find<Controllermaponline>().GetLocsms(),
                    code: 'موقعیت');
              }
            }
            //print('Link: ${value} \n response: ${val}');
            if (val.length > 10) {
              int spead =
                  (CompreserCode.indexOf(val.split(r'$OK$')[1][0]) * 64) +
                      CompreserCode.indexOf(val.split(r'$OK$')[1][1]);
              if (spead > 200) {
                String Chr2 = val.split(r'$OK$')[1][1].toString();

                // print(Chr2);
                if (Chr2 == 'a') {
                  Get.find<Controllerhomepage>().TimeLightGuide.value = 5;
                } else {
                  Get.find<Controllerhomepage>().TimeLightGuide.value = 0;
                }
              } else {
                Get.find<Controllerkm>().calculateSequence(spead);
              }
              Get.find<Controllermap>().GetXY(text: val.split(':')[2]);

              TimeE222.value = 1;
            } else {
              if (context != null) {
                if (TimeE222.value < 2) {
                  if (!Get.find<Controllerinternet>().FirstsGetId.value) {
                    DirectInquiry(
                        () => Get.find<Controllermaponline>().GetLocsms(),
                        code: 'موقعیت');
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: (10)),
                      content: Text('پسورد دستگاه را تغییر بدهید'),
                    ),
                  );
                }
              }
              TimeE222.value += 1;
            }
          }
        } catch (e) {}
      } else {
        if (Get.find<Controllerinfo>().Phone.value.length == 11 &&
            Maponline.value) {
          if (!Get.find<Controllerinternet>().FirstsGetId.value) {
            if (!sendsmsloc.value) {
              print('send loc offline');
              sendsmsloc.value = true;
              DirectInquiry(() => Get.find<Controllermaponline>().GetLocsms(),
                  code: 'موقعیت');
            }
          }
        }
      }
    }
  }

  GetLocsms() {
    if (Get.find<Controllerother>().TextInuiry.value.contains('=')) {
      String XY = Get.find<Controllerother>()
          .TextInuiry
          .value
          .split('=')[1]
          .removeAllWhitespace;
      Get.find<Controllermap>().GetXY(text: XY);
    }
  }
}
