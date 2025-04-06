import 'package:get/get.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerHistory.dart';
import '/Controller/ControllerHomepage.dart';
import '/Controller/ControllerInfo.dart';
import '/Controller/ControllerInquiry.dart';
import '/Controller/ControllerInternet.dart';
import '/Controller/ControllerMapOnline.dart';
import '/Controller/ControllerOptions.dart';
import '/Controller/ControllerOther.dart';
import '/Controller/ControllerSetting.dart';
import '/Controller/ControllerStateDev.dart';
import '/Controller/ControllerTest.dart';
import '/Controller/Controllercontact.dart';
import '/Core/Widget/Map/ControllerMap.dart';
import '/Page/SplashScreen/ControllerSplashScreen.dart';
import '/Page/SplashScreen/ControolerLock.dart';
import '../Core/Widget/KM/ControllerKm.dart';

class mybinding implements Bindings {
  @override
  void dependencies() {
    Get.put(Controllerdatabase(), permanent: true);
    Get.put(Controllerinfo(), permanent: true);
    Get.put(Controllerinternet(), permanent: true);
    Get.put(Controllerkm(), permanent: true);
    Get.put(Controllertest(), permanent: true);
    Get.put(Controllermap(), permanent: true);
    Get.put(Controllerhistory(), permanent: true);
    Get.put(Controllerother(), permanent: true);
    Get.put(Controllermaponline(), permanent: true);
    Get.put(Controllercontact(), permanent: true);
    Get.put(Controllerreportsms(), permanent: true);
    Get.put(Controllerstatedev(), permanent: true);
    Get.put(ControllerLock(), permanent: true);
    Get.put(Controllersetting(), permanent: true);
    Get.put(Controllerhomepage(), permanent: true);
    Get.put(Controlleroptions(), permanent: true);
    Get.put(Controllersplashscreen(), permanent: true);
    // TODO: implement dependencies
  }
}
