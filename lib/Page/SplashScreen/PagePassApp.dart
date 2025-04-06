import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Page/HomePage/HomePage.dart';
import '/Page/SplashScreen/ControolerLock.dart';
import '/Page/SplashScreen/PageLock.dart';
import '/Page/Test/TestDegree.dart';
import 'package:just_audio/just_audio.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

PagePassApp(BuildContext context) async {
  await Future.delayed(Duration(milliseconds: 100));
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  Get.find<ControllerLock>().StatePass.value =
      await prefs.getBool('StatePass') ?? false;
  if (Get.find<ControllerLock>().StatePass.value) {
    Get.off(Pagelock());
  } else {
    AudioPlayer player = AudioPlayer();
    await player.setAsset('assets/sound/intro1.mp3');
    await player.play();
    player.dispose();
    GoToHomePage();
  }
}

biumetric() async {
  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool isBiometricSupported = await localAuthentication.isDeviceSupported();
  bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

  bool isAuthenticated = false;

  if (isBiometricSupported && canCheckBiometrics) {
    isAuthenticated = await localAuthentication.authenticate(
      localizedReason: 'لطفا اثر انگشت خود را وارد کنید',
    );
  }
  if (isAuthenticated) {
    GoToHomePage();
  } else {
    Get.snackbar('خطا', 'دوباره وارد کنید');
  }
}

GoToHomePage() async {
  await Future.delayed(
    Duration(milliseconds: 20),
  );
  Get.off(() => Homepage(),
      duration: Duration(milliseconds: 100),
      transition: Transition.topLevel,
      curve: Curves.bounceIn);
  //Get.offAll(() => HomePage_commax());
}
