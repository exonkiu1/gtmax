import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerInfo.dart';
import '/Controller/ControllerOptions.dart';
import '/Page/AddDevice/AddDevice.dart';
import '/Page/Contact/Contact.dart';
import '/Page/History/History.dart';
import '/Page/InquirySms/InquirySms.dart';
import '/Page/SettingApp/SettingApp.dart';
import '/Page/SettingDevice/SettingDevice.dart';
import '/Page/SettingInternet/SettingInternet.dart';
import '/Page/SettingSim/SettingSim.dart';
import '/Page/Settingpro/Settingpro.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/options/back.gif'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Obx(() {
                return Transform.translate(
                  offset: Offset(-Get.height * 0.35, -Get.height * 0.35),
                  child: Transform.rotate(
                    angle: Get.find<Controlleroptions>().DegreeMonth.value *
                        (math.pi / 180),
                    child: OverflowBox(
                      maxHeight: double.infinity,
                      maxWidth: double.infinity,
                      child: Container(
                        width: Get.height * 1,
                        height: Get.height * 1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/image/options/month2.png'),
                        )),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const FlutterLogo(),
                  Container(),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      children: List.generate(
                          ListOptions.length,
                          (i) => InkWell(
                              onTap: () => Get.to(
                                  ListOptions.values.elementAt(i)['page']),
                              child: Column(
                                children: [
                                  Container(
                                    width: Get.width * 0.25,
                                    height: Get.width * 0.25,
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/image/options/${ListOptions.values.elementAt(i)['image']}.png'))),
                                  ),
                                  Text(
                                    ListOptions.keys.elementAt(i),
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ))),
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.bottomSheet(Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Obx(() {
                        return Column(
                          children: List.generate(
                            Get.find<Controllerdatabase>().Lenght.value,
                            (i) => InkWell(
                              onTap: () {
                                Get.find<Controllerdatabase>().GetDev(i: i);
                                Get.back();
                              },
                              child: Container(
                                width: Get.width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all()),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.05, vertical: 5),
                                margin: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() {
                                      return Text(
                                        Get.find<Controllerdatabase>()
                                            .Devs[i]
                                            .Name,
                                      );
                                    }),
                                    Obx(() {
                                      return Text(Get.find<Controllerdatabase>()
                                          .Devs[i]
                                          .Phone);
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    )),
                    child: Container(
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.05, vertical: 5),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return Text(
                              Get.find<Controllerinfo>().Name.value,
                              style: const TextStyle(),
                            );
                          }),
                          Obx(() {
                            return Text(
                              Get.find<Controllerinfo>().Phone.value,
                              style: const TextStyle(),
                            );
                          }),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Map<String, Map<String, dynamic>> ListOptions = {
  'افزدون دستگاه': {'image': 'add', 'page': const Adddevice()},
  'کاربران': {'image': 'contact', 'page': const Contacts()},
  'گزارش مسیرها': {'image': 'history', 'page': const History()},
  'ارتباط سرور': {'image': 'internet', 'page': const Settinginternet()},
  'صندوق پیامها': {'image': 'inquirysms', 'page': const Reportsms()},
  'تنظیمات دستگاه': {'image': 'settingdev', 'page': const Settingdevice()},
  'تنظیمات پیشرفته': {'image': 'settingpro', 'page': const Settingpro()},
  'تنظیمات  اپ': {'image': 'settingapp', 'page': const Settingapp()},
  'تنظیمات سیمکارت': {'image': 'sim', 'page': const Settingsim()},
  'ارتباط باما': {'image': 'info', 'page': null},
};
