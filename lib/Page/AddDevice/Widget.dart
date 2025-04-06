import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerOther.dart';

import '../../Controller/ControllerInfo.dart';
import '../../Core/Widget/DecorationBox.dart';

class WidgetSelectedSim extends StatelessWidget {
  const WidgetSelectedSim({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: Get.find<Controllerinfo>().ShowSelectedSim.value,
        child: Container(
          width: Get.width * 0.9,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(
            vertical: 5,
          ),
          decoration: decoration(),
          child: Column(
            children: [
              Text('انتخاب سیمکارت برای ارسال دستورات'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WidgetSim(
                    sim: 0,
                  ),
                  WidgetSim(
                    sim: 1,
                  )
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

class WidgetSim extends StatelessWidget {
  const WidgetSim({super.key, required this.sim});
  final int sim;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.find<Controllerother>().simcard.value = sim,
      child: Obx(() {
        return Container(
          width: Get.width * 0.3,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: decoration(
              color: Get.find<Controllerother>().simcard.value == sim),
          child: Center(child: Text('sim ${sim + 1}')),
        );
      }),
    );
  }
}
