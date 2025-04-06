import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Page/SplashScreen/ControolerLock.dart';
import '/Page/SplashScreen/PagePassApp.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Pagelock extends StatelessWidget {
  const Pagelock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  4,
                  (i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Obx(() {
                          return Visibility(
                              visible: Get.find<ControllerLock>()
                                      .Value
                                      .value
                                      .length >=
                                  (i + 1),
                              child: Icon(Icons.panorama_photosphere_sharp),
                              replacement: Icon(Icons.panorama_fisheye_sharp));
                        }),
                      )),
            ),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.spaceEvenly,
              children: Number.map((int value) => InkWell(
                    onTap: () =>
                        Get.find<ControllerLock>().EnterValue(value, context),
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
                  )).toList()
                ..add(InkWell(
                  onTap: () => biumetric(),
                  child: Container(
                    width: Get.width * 0.2,
                    height: Get.width * 0.2,
                    child: FittedBox(child: Icon(Icons.fingerprint)),
                  ),
                )),
            )
          ],
        ),
      ),
    );
  }
}

List<int> Number = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
