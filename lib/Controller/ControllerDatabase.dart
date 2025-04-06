import 'dart:math';

import 'package:get/get.dart';
import '/Controller/ControllerHomepage.dart';
import '/Controller/ControllerInfo.dart';
import '/Controller/ControllerInternet.dart';
import '/Controller/ControllerOther.dart';
import '/Controller/ControllerStateDev.dart';
import '/Controller/Controllercontact.dart';
import '/Core/SendOrder/OrderSms.dart';
import '/DataBase/DateBase.dart';
import '/DataBase/Model.dart';
import '/Page/HomePage/HomePage.dart';
import '/Page/SplashScreen/SplashScreen.dart';
import '../Page/AddDevice/AddDevice.dart' as add;
import 'ControllerSetting.dart';

class Controllerdatabase extends GetxController {
  @override
  void onInit() {
    GetDev(splahscreen: true);
    // TODO: implement onInit
    super.onInit();
  }

  RxInt Lenght = 0.obs;
  RxInt Index = 0.obs;
  RxString id = ''.obs;
  RxList<Car> Devs = <Car>[].obs;
  GetDev({int i = 0, bool splahscreen = false}) async {
    Devs.value = await DataBaseCar.instance.GetDevs();
    Lenght.value = Devs.length;

    if (Devs.length != 0) {
      Index.value = i;

      Car model = Devs[i];
      print(model);
      id.value = model.id;
      Get.find<Controllerinfo>().GetInfo(model);
      Get.find<Controllerinternet>().GetInternet(model);
      Get.find<Controllerstatedev>().GetStateDev(model);
      Get.find<Controllercontact>().GetContact(id.value);
      Get.find<Controllerhomepage>().GetHomepage(model);
      Get.find<Controllersetting>().GetSetting(model);
      if (splahscreen) {
        await Future.delayed(
            Duration(milliseconds: 150), () => Get.off(() => Splashscreen()));
      }
    } else {
      await Future.delayed(
          Duration(seconds: 1), () => Get.off(() => add.Adddevice()));

      /// Page Add Device
    }
  }

  AddDev() async {
    var rand = Random();
    int id = rand.nextInt(1000000);
    Car dev = Car(
        id: '$id',
        Name: add.tf_name.text,
        Phone: add.tf_phone.text,
        Oprator: Get.find<Controllerother>().Oprator.value,
        simcard: Get.find<Controllerother>().simcard.value.toString());
    await DataBaseCar.instance.AddDev(dev);
    await Get.find<Controllercontact>().AddContact('${id}');
    await GetDev(i: Lenght.value);
    Get.off(() => Homepage());
    Get.find<Controllerinternet>().StartSyncDev();
  }

  UpdateDev() async {
    Car dev = Car(
        id: id.value,
        Name: Get.find<Controllerinfo>().Name.value,
        Phone: Get.find<Controllerinfo>().Phone.value,
        Oprator: Get.find<Controllerinfo>().Oprator.value,
        ModelCar: Get.find<Controllerhomepage>().ModelCar.value,
        IdDev: Get.find<Controllerinternet>().Id.value,
        PassUser: Get.find<Controllerinternet>().Pass.value,
        StateInternet: '${Get.find<Controllerinternet>().State.value}',
        StateDev: Get.find<Controllerstatedev>().StateDev.value,
        SpeadDifference: Get.find<Controllersetting>().SpeadDifference.value,
        SpeadLimit: Get.find<Controllersetting>().SpeadLimit.value,
        StartEnable: Get.find<Controllersetting>().StartEnable.value,
        LocationSendAfterFabric:
            '${Get.find<Controllersetting>().LocationSendAfterFabric.value}',
        LocationSendAfterSms:
            Get.find<Controllersetting>().LocationSendAfterSms.value,
        DoorpType: Get.find<Controllersetting>().DoorpType.value,
        ImpactIntensity: Get.find<Controllersetting>().ImpactIntensity.value,
        ShockAlarm: Get.find<Controllersetting>().ShockAlarm.value,
        ShockNumber: Get.find<Controllersetting>().ShockNumber.value,
        Vehicle: Get.find<Controllersetting>().Vehicle.value,
        ChildrenLock: Get.find<Controllersetting>().ChildrenLock.value,
        SencorsTime: Get.find<Controllersetting>().SencorsTime.value,
        StartPositionSend:
            Get.find<Controllersetting>().StartPositionSend.value,
        UrgentOpreation: Get.find<Controllerstatedev>().UrgentOpreation.value,
        TypeAlarmSpead: Get.find<Controllersetting>().TypeAlarmSpead.value,
        StateSendLocationAfterSms:
            '${Get.find<Controllersetting>().StateSendLocationAfterSms.value}',
        simcard: Get.find<Controllerinfo>().simcard.value.toString());
    //  print('update dev:$dev');
    await DataBaseCar.instance.UpdateDev(dev);
  }

  ///
  ///
  ///
  DeleteDev() async {
    await DataBaseCar.instance.DeleteDev(id.value);
    GetDev();
  }

  ///
  ///
  ResetDev() async {
    Car dev = Car(
        id: id.value,
        Name: Get.find<Controllerinfo>().Name.value,
        Phone: Get.find<Controllerinfo>().Phone.value,
        Oprator: Get.find<Controllerinfo>().Oprator.value,
        ModelCar: Get.find<Controllerhomepage>().ModelCar.value);
    Get.find<Controllercontact>().AddContact(id.value);
    await DataBaseCar.instance.UpdateDev(dev);
    await Get.find<Controllercontact>().AddContact(id.value);
    GetDev(i: Index.value);
  }

  Future<String> ReSetDev2() async {
    ResetDev();
    return 'G64';
  }
}
