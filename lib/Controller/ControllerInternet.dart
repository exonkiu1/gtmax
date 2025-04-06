import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerInfo.dart';
import '/Controller/ControllerOther.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../Core/SendOrder/OrderSms.dart';
import '../DataBase/Model.dart';

TextEditingController tf_pass_before = TextEditingController(),
    tf_pass_new = TextEditingController(),
    tf_pass_new_repeat = TextEditingController();

class Controllerinternet extends GetxController {
  RxString Id = ''.obs;
  RxString Pass = ''.obs;
  RxBool State = false.obs;
  RxBool FirstsGetId = false.obs;
  GetInternet(Car model) {
    Id.value = model.IdDev;
    //Pass.value = '3653';
    if (model.PassUser.length < 3) {
      Pass.value = '1234';
    } else {
      Pass.value = model.PassUser;
    }
    State.value = model.StateInternet == 'true' ? true : false;
  }

  RxString TextSyncing = 'دریافت مجدد تنظیمات اینترنت'.obs;
  RxBool Syncing = false.obs;
  StartSyncDev() async {
    FirstsGetId.value = true;
    final context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(hours: 1),
          backgroundColor: Colors.red.withOpacity(0.8),
          content: Text(
            'لطفا تا پیامک از دستگاه صبر کنید برنامه را ترک نکنید'
                .toPersianDigit(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textDirection: TextDirection.rtl,
          )));
    }
    Syncing.value = true;
    TextSyncing.value = 'تنظیم APN';
    DirectInquiry(() => GetId(),
        code: 'GPN__${ApnOprator[Get.find<Controllerinfo>().Oprator.value]}#',
        controller: '');
  }

  GetId() async {
    TextSyncing.value = 'دریافت id';
    if (Get.find<Controllerother>().TextInuiry.value.contains('تنظیمات')) {
      DirectInquiry(() => GetPassword(), code: 'SGPIIDEEE');
    } else {
      if (Get.find<Controllerother>().TextInuiry.value.contains('#')) {
        GetPassword();
      }
    }
    FirstsGetId.value = false;
  }

  GetPassword() {
    final context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
    Id.value = Get.find<Controllerother>().TextInuiry.value.substring(0, 4);
    print('this is pass: ${Id.value}');
    Syncing.value = false;
    Get.find<Controllerdatabase>().UpdateDev();
    Get.snackbar('تبریک', 'تنظیمات اینترنت با موفقیت انجام شد');

    // Get.off(HomePage6());
  }

  Future<String> ChangeStateInternet(int index, bool val) async {
    State.value = val;

    Get.find<Controllerdatabase>().UpdateDev();
    return 'SGPRSS__${index}000000000000000#';
  }

  RegisterPassUser() async {
    String value =
        'http://h5q.ir/api/webapi/GetGtMaxPass/${Id.value}${tf_pass_before.text}${tf_pass_new.text}';
    print('Link:  ${value}');

    var dio = Dio();
    try {
      var response = await dio.request(
        value,
        options: Options(
          method: 'GET',
        ),
      );
      //print('this is responsive : ${json.encode(response.data)}');
      print('this is :');
      if (response.statusCode == 200) {
        switch ('${json.encode(response.data)}') {
          case '"EEC0"':
            Get.snackbar('خطا', 'رمز اولیه را اشتباه وارد کردید');
            break;
          case '"EEC9"':
            Get.snackbar('خطا', 'مجدد تلاش کلید');
            break;
          default:
            {
              Pass.value = tf_pass_new.text;

              Get.find<Controllerdatabase>().UpdateDev();
              Get.snackbar('توجه', 'رمز با موفقیت ثبت شد');
            }
        }

        if ('${json.encode(response.data)}' != 'EEC0') {}
        print('yes: ${json.encode(response.data)}');
        Get.snackbar('توجه', 'دستور به دستگاه رسید');
      } else {
        print('no: ${response.statusMessage}');
        //  SendSms(code);
      }
    } catch (e) {
      Get.snackbar('خطا', 'مجدد تلاش کلید');
      //  SendSms(code);
    }
    tf_pass_before.text = '';
    tf_pass_new.text = '';
    tf_pass_new_repeat.text = '';
    /*    fn_pass_before.unfocus();
    fn_pass_new.unfocus();
    fn_pass_new_repeat.unfocus(); */
  }
}

Map<String, String> ApnOprator = {
  'ir': 'mtnirancell',
  'ha': 'mcinet',
  'rl': 'RighTel',
  'sh': 'shatelmobile',
};
