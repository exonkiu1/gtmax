import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '/Controller/ControllerInternet.dart';
import '/Core/SendOrder/OrderSms.dart';
import '/Core/Widget/DecorationBox.dart';

class Settinginternet extends StatefulWidget {
  const Settinginternet({super.key});

  @override
  State<Settinginternet> createState() => _SettinginternetState();
}

class _SettinginternetState extends State<Settinginternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetSyncInternet(),
            PasswordInternet(),
            /*  Obx(() {
              return Visibility(
                visible: Get.find<Controllerinternet>().Id.value == '',
                child: WidgetSyncInternet(),
                replacement: PasswordInternet(),
              );
            }) */
          ],
        ),
      ),
    );
  }
}

class WidgetSettingPassStateInternet extends StatelessWidget {
  const WidgetSettingPassStateInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width * 0.9,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Text('وضعیت اینترنت'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => SendOrder(
                        context,
                        () => Get.find<Controllerinternet>()
                            .ChangeStateInternet(1, true)),
                    child: Obx(() {
                      return Container(
                        width: Get.width * 0.3,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20),
                            color: Get.find<Controllerinternet>().State.value
                                ? Colors.grey
                                : null),
                        child: Center(child: Text('فعال')),
                      );
                    }),
                  ),
                  InkWell(
                    onTap: () => SendOrder(
                        context,
                        () => Get.find<Controllerinternet>()
                            .ChangeStateInternet(0, false)),
                    child: Obx(() {
                      return Container(
                        width: Get.width * 0.3,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20),
                            color: !Get.find<Controllerinternet>().State.value
                                ? Colors.grey
                                : null),
                        child: Center(child: Text('غیرفعال')),
                      );
                    }),
                  )
                ],
              )
            ],
          ),
        ),
        Obx(() {
          return Visibility(
              visible: Get.find<Controllerinternet>().State.value,
              child: PasswordInternet());
        })
      ],
    );
  }
}

class PasswordInternet extends StatelessWidget {
  const PasswordInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        width: Get.width * 0.9,
        padding: EdgeInsetsDirectional.only(bottom: 10),
        decoration: decoration(),
        child: Column(
          children: [
            WidgetTextfieldPass(
                controller: tf_pass_before,
                hint: 'پسورد فعلی دستگاه را وارد نمایید'),
            WidgetTextfieldPass(
                controller: tf_pass_new,
                hint: 'پسورد جدید دستگاه را وارد نمایید'),
            WidgetTextfieldPass(
                controller: tf_pass_new_repeat,
                hint: 'پسورد جدید دستگاه را دوباره وارد نمایید'),
            InkWell(
              onTap: () => Get.find<Controllerinternet>().RegisterPassUser(),
              child: Container(
                width: Get.width * 0.3,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                child: Center(
                  child: Text('ثبت پسورد'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetTextfieldPass extends StatelessWidget {
  const WidgetTextfieldPass(
      {super.key, required this.controller, required this.hint});
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: Get.width * 0.7,
          child: TextField(
            textAlign: TextAlign.center,
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: InputDecoration(hintText: hint),
          )),
    );
  }
}

class WidgetSyncInternet extends StatelessWidget {
  const WidgetSyncInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      padding: EdgeInsets.all(8),
      decoration: decoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return Text(
              Get.find<Controllerinternet>().TextSyncing.value,
              textDirection: TextDirection.rtl,
            );
          }),
          Obx(() {
            return Visibility(
              visible: !Get.find<Controllerinternet>().Syncing.value,
              replacement: CircularProgressIndicator(),
              child: InkWell(
                onTap: () => Get.find<Controllerinternet>().StartSyncDev(),
                child: Container(
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: Center(child: Text('شروع')),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
