import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '/Controller/ControllerHomepage.dart';
import '/Controller/ControllerOther.dart';
import '/Core/Widget/DecorationBox.dart';
import '/Page/SettingApp/PageChangeApp.dart';
import '/Page/SplashScreen/ControolerLock.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SettingDevice/WidgetSettingDevice.dart';

class Settingapp extends StatelessWidget {
  const Settingapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              WidgetSecurityApp(),
              Container(
                width: Get.width * 0.9,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: decoration(),
                child: Column(
                  children: [WidgetDeleteDev(), WidgetSettingReset()],
                ),
              ),
              SelectedModel(),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectedModel extends StatelessWidget {
  const SelectedModel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: Get.width * 0.9,
            decoration: decoration(),
            padding: EdgeInsets.all(3),
            child: Column(
              children: [
                Text('تصویر وسبله نقلیه در صفحه اصلی'),
                SearchChoices.single(
                  items: ListCar.map<DropdownMenuItem<String>>((String value) =>
                      DropdownMenuItem(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/image/homepage/car/${value}.png',
                                height: 50,
                              ),
                              Text(
                                value,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      )).toList(),
                  value: Get.find<Controllerhomepage>().ModelCar.value,
                  hint: "Select one",
                  searchHint: "Select one",
                  onChanged: (value) {
                    Get.find<Controllerhomepage>().ChangeModelCar(value);
                  },
                  isExpanded: true,
                ),
              ],
            ),
          ),
        ));
  }
}

class WidgetSecurityApp extends StatelessWidget {
  const WidgetSecurityApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: decoration(),
      child: Column(
        children: [
          Text('تنظیمات امنیت ورود به نرم افزار'),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => Get.to(Pagechangeapp()),
                child: Container(
                  width: Get.width * 0.3,
                  decoration: decoration(),
                  child: Center(child: Text('تغییر پسورد')),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (Get.find<ControllerLock>().StatePass.value) {
                    Get.find<ControllerLock>().StatePass.value = false;
                  } else {
                    Get.find<ControllerLock>().StatePass.value = true;
                  }
                  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
                  await prefs.setBool(
                      'StatePass', Get.find<ControllerLock>().StatePass.value);
                },
                child: Obx(() {
                  return Icon(Get.find<ControllerLock>().StatePass.value
                      ? Icons.lock
                      : Icons.lock_open);
                }),
              )
            ],
          )
        ],
      ),
    );
  }
}

const List<String> ListCar = [
  '207',
  '405',
  'ال نود',
  'بوگاتی',
  'پژوپارس',
  'تارا',
  'جی کلاس',
  'دنا',
  'رانا',
  'ریرا',
  'سانتافه',
  'سمند',
  'سورن',
  'شاهین',
  'کامیون',
  'کوییک',
  'موتور'
];
