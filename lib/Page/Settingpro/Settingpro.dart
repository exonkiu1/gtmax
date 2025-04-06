import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Core/Widget/DecorationBox.dart';
import '/Page/Settingpro/SettingSpead.dart';

class Settingpro extends StatelessWidget {
  const Settingpro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () => Get.to(() => Settingspead()),
              child: Container(
                width: Get.width * 0.9,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: decoration(),
                child: Column(
                  children: [Text('تنظیمات سرعت مجاز')],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
