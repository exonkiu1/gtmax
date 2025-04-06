import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_rx/get_rx.dart';
import '/Page/HomePage/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerLock extends GetxController {
  @override
  Future<void> onInit() async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    Password.value = await prefs.getString('password') ?? '0000';
    // TODO: implement onInit
    super.onInit();
  }

  RxString Value = ''.obs;
  RxString Password = ''.obs;
  RxBool StatePass = false.obs;
  RxString TextTitle = ''.obs;
  EnterValue(int i, BuildContext context) {
    Value.value += '$i';
    if (Value.value.length == 4) {
      if (Password.value == Value.value) {
        Get.off(Homepage());
        Value.value = '';
      } else {
        Value.value = '';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('پسورد  اشتباه است دوباره وارد کنید'),
            Icon(
              Icons.error,
              color: Colors.red,
            )
          ],
        )));
      }
    }
  }

  PassNow(BuildContext context) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();

    String getpass = await prefs.getString('password') ?? '0000';
    if (getpass != '0000') {
      TextTitle.value = 'پسورد فعلی را وارد کنید';
      if (Value.value.length == 4) {
        if (Value.value == Password.value) {
          Value.value = '';
          NewPass(context);
        } else {
          Value.value = '';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('پسورد  اشتباه است دوباره وارد کنید'),
              Icon(
                Icons.error,
                color: Colors.red,
              )
            ],
          )));
        }
      }
    } else {
      NewPass(context);
    }
  }

  RxString CopyNewPass = ''.obs;
  NewPass(BuildContext context) {
    TextTitle.value = 'پسورد جدید را وارد کنید';
    if (Value.value.length == 4) {
      CopyNewPass.value = Value.value;
      Value.value = '';
      CheckPass(context);
    }
  }

  CheckPass(BuildContext context) {
    TextTitle.value = 'پسورد جدید را تکرار کنید';
    if (Value.value.length == 4) {
      if (Value.value == CopyNewPass.value) {
        final SharedPreferencesAsync prefs = SharedPreferencesAsync();
        prefs.setString('password', Value.value);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('پسورد جدید اعمال شد'),
            /*  Icon(
              Icons.subdirectory_arrow_right,
              color: Colors.green,
            ) */
          ],
        )));
        Get.back();
      } else {
        Value.value = '';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('پسورد  اشتباه است دوباره وارد کنید'),
            Icon(
              Icons.error,
              color: Colors.red,
            )
          ],
        )));
      }
    }
  }
}
