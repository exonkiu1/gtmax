import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../SettingDevice/SettingDevice.dart';

class Settingspead extends StatelessWidget {
  const Settingspead({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            WidgetSpeadLimit(),
            WidgetSpeadDifference(),
            WidgetTypeAlarmSpead()
          ],
        ),
      ),
    );
  }
}
