import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '/Page/SplashScreen/ControllerSplashScreen.dart';
import '/Page/SplashScreen/PagePassApp.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Get.find<Controllersplashscreen>().RotateLogo();
    PagePassApp(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Align(
              child: Obx(() {
                return Transform.rotate(
                  angle: Get.find<Controllersplashscreen>().degreelogo.value *
                      (math.pi / 180),
                  child: Container(
                    width: Get.width * 0.8,
                    height: Get.width * 0.8,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image/homepage/on.png'))),
                  ),
                );
              }),
            ),
            Align(
              child: Container(
                width: Get.width * 0.5,
                height: Get.width * 0.5,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/image/splashscreen/logo.png'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
