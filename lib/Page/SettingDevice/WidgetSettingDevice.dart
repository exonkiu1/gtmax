import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerDatabase.dart';
import '/Core/Widget/DecorationBox.dart';

class WidgetDeleteDev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.defaultDialog(
              title: 'هشدار',
              middleText: 'از حذف دستگاه مطمعن هستید؟',
              textConfirm: 'بله',
              textCancel: 'لغو',
              onConfirm: () {
                Get.back();
                Get.find<Controllerdatabase>().DeleteDev();
              },
            ),
            child: Container(
              width: Get.width * 0.3,
              decoration: decoration(),
              child: Center(
                child: Text('اعمال'),
              ),
            ),
          ),
          Text('حذف دستگاه')
        ],
      ),
    );
  }
}

class WidgetSettingReset extends StatelessWidget {
  const WidgetSettingReset({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.defaultDialog(
              title: 'هشدار',
              middleText: 'از ریست نرم افزار مطمعن هستید؟',
              textConfirm: 'بله',
              textCancel: 'لغو',
              onConfirm: () {
                Get.back();
                Get.find<Controllerdatabase>().ResetDev();
              },
            ),
            child: Container(
              width: Get.width * 0.3,
              decoration: decoration(),
              child: Center(
                child: Text('اعمال'),
              ),
            ),
          ),
          Text('ریست نرم افزار')
        ],
      ),
    );
  }
}
