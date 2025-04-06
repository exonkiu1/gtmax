import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../SplashScreen/ControolerLock.dart';
import '../SplashScreen/PageLock.dart';

class Pagechangeapp extends StatefulWidget {
  const Pagechangeapp({super.key});

  @override
  State<Pagechangeapp> createState() => _PagechangeappState();
}

class _PagechangeappState extends State<Pagechangeapp> {
  @override
  void initState() {
    Get.find<ControllerLock>().PassNow(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(() {
              return Text(Get.find<ControllerLock>().TextTitle.value);
            }),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    Get.find<ControllerLock>().Value.value.length,
                    (i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            Get.find<ControllerLock>()
                                .Value
                                .value[i]
                                .toPersianDigit(),
                            style: TextStyle(fontSize: 25),
                          ),
                        )),
              );
            }),
            Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.spaceEvenly,
                children: Number.map((int value) => InkWell(
                      onTap: () {
                        Get.find<ControllerLock>().Value.value += '$value';
                        switch (Get.find<ControllerLock>().TextTitle.value) {
                          case 'پسورد فعلی را وارد کنید':
                            Get.find<ControllerLock>().PassNow(context);
                          case 'پسورد جدید را وارد کنید':
                            Get.find<ControllerLock>().NewPass(context);
                          case 'پسورد جدید را تکرار کنید':
                            Get.find<ControllerLock>().CheckPass(context);
                            break;
                          default:
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10, horizontal: Get.width * 0.05),
                        width: Get.width * 0.2,
                        height: Get.width * 0.2,
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            border: Border.all(width: 5),
                            borderRadius: BorderRadius.circular(100)),
                        child: FittedBox(
                          child: Center(
                            child: Text(
                              '${value}'.toPersianDigit(),
                            ),
                          ),
                        ),
                      ),
                    )).toList())
          ],
        ),
      ),
    );
  }
}
