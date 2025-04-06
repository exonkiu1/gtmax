import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerStateDev.dart';
import '/Core/SendOrder/OrderSms.dart';

import 'dart:math' as math;

import 'ControllerKm.dart';

class WidgetKM extends StatelessWidget {
  const WidgetKM({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.blue,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: Get.width * 0.9,
            height: Get.height * 0.26,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/km.png'))),
          ),
          Transform.translate(
            offset: Offset(0, Get.height * 0.08),
            child: Transform.rotate(
              angle: -160 * (math.pi / 180),
              child: Obx(() {
                return Transform.rotate(
                  angle: Get.find<Controllerstatedev>().Degree.value *
                      (math.pi / 180),
                  child: Container(
                      //  color: const Color.fromARGB(122, 244, 67, 54),
                      child: Image.asset(
                    'assets/image/homepage/on.png',
                    height: Get.height * 0.3,
                  )),
                );
              }),
            ),
          ),
          Transform.translate(
            offset: Offset(0, Get.height * 0.14),
            child: Container(
              width: Get.height * 0.4,
              height: Get.height * 0.4,
              decoration: BoxDecoration(
                  //  color: Color.fromARGB(207, 155, 39, 176),
                  borderRadius: BorderRadius.circular(360)),
              child: Center(
                child: Obx(() {
                  return Transform.rotate(
                    angle:
                        Get.find<Controllerkm>().spead.value * (math.pi / 180),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.red,
                        ),
                        Container(
                          width: Get.height * 0.35,
                          height: 2,
                          // color: Colors.red,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
          WidgetStateDev()
        ],
      ),
    );
  }
}

class WidgetStateDev extends StatelessWidget {
  const WidgetStateDev({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width * 0.64,
        height: Get.height * 0.2,
        //   color: const Color.fromARGB(104, 255, 235, 59),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => SendOrder(context,
                    () => Get.find<Controllerstatedev>().ChangeStateDev('قفل')),
                child: Image.asset(
                  'assets/icons/قفل.png',
                  height: 35,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => SendOrder(
                        context,
                        () => Get.find<Controllerstatedev>()
                            .ChangeStateDev('باز')),
                    child: Image.asset(
                      'assets/icons/قفل باز.png',
                      height: 35,
                    ),
                  ),
                  InkWell(
                    onTap: () => SendOrder(
                        context,
                        () => Get.find<Controllerstatedev>()
                            .ChangeStateDev('قفل سایلنت')),
                    child: Image.asset(
                      'assets/icons/قفل آژیر.png',
                      height: 35,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => SendOrder(
                          context,
                          () => Get.find<Controllerstatedev>()
                              .ChangeStateDev('صندوق پران')),
                      child: Image.asset(
                        'assets/icons/صندوق پران.png',
                        height: 35,
                      ),
                    ),
                    InkWell(
                      onTap: () => SendOrder(
                          context,
                          () => Get.find<Controllerstatedev>()
                              .ChangeStateDev('GT00')),
                      child: Image.asset(
                        'assets/icons/آژیر.png',
                        height: 35,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
