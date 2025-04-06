import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerInfo.dart';
import '/Core/SendOrder/OrderSms.dart';
import '/Core/Widget/DecorationBox.dart';

class Settingsim extends StatefulWidget {
  const Settingsim({super.key});

  @override
  State<Settingsim> createState() => _SettingsimState();
}

class _SettingsimState extends State<Settingsim> {
  @override
  void initState() {
    Get.find<Controllerinfo>().GetShowSelectedSim();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            WidgetEditPhone(),
            WidgetEditName(),
            WidgetSelectedSim()
          ],
        ),
      ),
    );
  }
}

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
      onTap: () {
        Get.find<Controllerinfo>().simcard.value = sim;

        Get.find<Controllerdatabase>().UpdateDev();
      },
      child: Obx(() {
        return Container(
          width: Get.width * 0.3,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: decoration(
              color: Get.find<Controllerinfo>().simcard.value == sim),
          child: Center(child: Text('sim ${sim + 1}')),
        );
      }),
    );
  }
}

class WidgetEditName extends StatelessWidget {
  const WidgetEditName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => DialogTextFieldSms(
              context,
              () => Get.find<Controllerinfo>().ChangeName(),
              description: ' نام دستگاه',
            ),
            child: Container(
              width: Get.width * 0.3,
              decoration: decoration(),
              child: Center(
                child: Text('ویرایش'),
              ),
            ),
          ),
          Text('ویرایش  نام دستگاه'),
        ],
      ),
    );
  }
}

class WidgetEditPhone extends StatelessWidget {
  const WidgetEditPhone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => DialogTextFieldSms(
                context, () => Get.find<Controllerinfo>().ChangePhone(),
                description: 'شماره تلفن دستگاه', KeyboardInt: true),
            child: Container(
              width: Get.width * 0.3,
              decoration: decoration(),
              child: Center(
                child: Text('ویرایش'),
              ),
            ),
          ),
          Text('ویرایش شماره تلفن'),
        ],
      ),
    );
  }
}
