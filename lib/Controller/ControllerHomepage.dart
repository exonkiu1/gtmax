import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerInfo.dart';
import '/Core/SendOrder/OrderSms.dart';
import '/Core/Widget/DecorationBox.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

import '../DataBase/Model.dart';

class Controllerhomepage extends GetxController {
  RxString LightCar = ''.obs;
  RxString ModelCar = 'بوگاتی'.obs;
  RxInt TimeLightGuide = 0.obs;
  LightGuideCar() async {
    AudioPlayer player = AudioPlayer();
    player.setAsset('assets/sound/tiktok2.mp3');
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));

      if (TimeLightGuide.value != 0) {
        player.load();
        await Future.delayed(Duration(milliseconds: 120));
        player.play();
        await Future.delayed(
            Duration(milliseconds: 130), () => LightCar.value = 'light/');
        await Future.delayed(
            Duration(milliseconds: 130), () => LightCar.value = '');
        await Future.delayed(
            Duration(milliseconds: 130), () => LightCar.value = 'light/');
        await Future.delayed(
            Duration(milliseconds: 130), () => LightCar.value = '');
        await Future.delayed(
            Duration(milliseconds: 130), () => LightCar.value = 'light/');
        await Future.delayed(
            Duration(milliseconds: 130), () => LightCar.value = '');
        TimeLightGuide.value -= 1;
      }
    }
  }

  GetHomepage(Car model) {
    ModelCar.value = model.ModelCar;
    print('ModelCar: ${ModelCar.value}');
  }

  ChangeModelCar(String value) {
    ModelCar.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
  }

  Listener() {
    AudioPlayer play = AudioPlayer();
    play.setAsset('assets/sound/telephone2.mp3');
    play.play();
    final context = Get.context;
    if (context != null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('یک روش برای شنود انتخاب کنید'),
              actions: [
                Center(
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pop();
                      launchUrl(Uri(
                          scheme: 'tel',
                          path: '${Get.find<Controllerinfo>().Phone.value}'));
                      //  await launch('tell:09922993653');
                    },
                    child: Container(
                      width: Get.width * 0.4,
                      decoration: decoration(),
                      child: Center(
                        child: Text('تماس به دستگاه'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      SendSms('شنود', check: false);
                    },
                    child: Container(
                      width: Get.width * 0.4,
                      decoration: decoration(),
                      child: Center(
                        child: Text('تماس  دستگاه به شما'),
                      ),
                    ),
                  ),
                )
              ],
            );
          });
    }
  }

  IntroHomePage() async {
    /*  AudioPlayer player = AudioPlayer();
    await player.setAsset('assets/sound/alarm.mp3');
    player.play();
    for (var i = 0; i < 4; i++) {
      LightCar.value = 'light/';
      await Future.delayed(Duration(milliseconds: 100));
      LightCar.value = '';
      await Future.delayed(Duration(milliseconds: 100));
    } */
    // await Future.delayed(Duration(milliseconds: 1000));
    AudioPlayer player = AudioPlayer();
    await player.setAsset('assets/sound/intro2.mp3');
    await player.play();
  }

  PlayStateOn() async {
    AudioPlayer player = AudioPlayer();
    await player.setAsset('assets/sound/singlealarm.mp3');
    player.play();
    LightCar.value = 'light/';
    await Future.delayed(Duration(seconds: 2));
    LightCar.value = '';
    player.dispose();
  }

  PlayStateOff() async {
    AudioPlayer player = AudioPlayer();
    await player.setAsset('assets/sound/alarm.mp3');
    player.play();
    for (var i = 0; i < 4; i++) {
      LightCar.value = 'light/';
      await Future.delayed(Duration(milliseconds: 100));
      LightCar.value = '';
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  PlayStateOnSilent() async {
    LightCar.value = 'light/';
    await Future.delayed(Duration(seconds: 2));
    LightCar.value = '';
  }
}
