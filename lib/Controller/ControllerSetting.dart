import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerOther.dart';
import '/Page/SettingDevice/SettingDevice.dart';
import '../DataBase/Model.dart';

class Controllersetting extends GetxController {
  RxString SpeadDifference = ''.obs;
  RxString SpeadLimit = ''.obs;
  RxString StartEnable = ''.obs;
  RxBool LocationSendAfterFabric = false.obs;
  RxString LocationSendAfterSms = ''.obs;
  RxString DoorpType = ''.obs;
  RxString ImpactIntensity = ''.obs;
  RxString ShockAlarm = ''.obs;
  RxString ShockNumber = ''.obs;
  RxString Vehicle = ''.obs;
  RxString ChildrenLock = ''.obs;
  RxString SencorsTime = ''.obs;
  RxString StartPositionSend = ''.obs;
  RxString TypeAlarmSpead = ''.obs;
  RxBool StateSendLocationAfterSms = true.obs;
  GetSetting(Car model) {
    SpeadDifference.value = model.SpeadDifference;
    SpeadLimit.value = model.SpeadLimit;
    StartEnable.value = model.StartEnable;
    LocationSendAfterSms.value = model.LocationSendAfterSms;
    DoorpType.value = model.DoorpType;
    ImpactIntensity.value = model.ImpactIntensity;
    if (int.tryParse(model.ShockNumber) != null) {
      ShockNumber.value = model.ShockNumber;
    } else {
      ShockNumber.value = '90';
    }
    print('shoke number: ${ShockNumber.value}');
    if (int.tryParse(model.SpeadLimit) != null) {
      SpeadLimit.value = model.SpeadLimit;
    } else {
      SpeadLimit.value = '50';
    }
    if (int.tryParse(model.SpeadDifference) != null) {
      SpeadDifference.value = model.SpeadDifference;
    } else {
      SpeadDifference.value = '180';
    }
    StateSendLocationAfterSms.value =
        model.StateSendLocationAfterSms == 'true' ? true : false;
    LocationSendAfterFabric.value =
        model.LocationSendAfterFabric == 'true' ? true : false;
    TypeAlarmSpead.value = model.TypeAlarmSpead;
    ShockNumber.value = model.ShockNumber;
    Vehicle.value = model.Vehicle;
    ChildrenLock.value = model.ChildrenLock;
    SencorsTime.value = model.SencorsTime;
    StartPositionSend.value = model.StartPositionSend;
  }

  Future<String> ChangeStateSendLocationAfterSms(bool value) async {
    StateSendLocationAfterSms.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
    return 'GTMAX9__${value ? '1' : '99'}';
  }

  Future<String> ChangeAlarmSpead(String value) async {
    TypeAlarmSpead.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
    return 'GTMAX16__${AlarmTypeSpead[value]}';
  }

  Future<String> ChangeSpeadDifference() async {
    Get.find<Controllerdatabase>().UpdateDev();
    return 'GTMAX15__${(int.parse(SpeadDifference.value) - (int.parse(SpeadLimit.value)))}';
    //15
  }

  Future<String> ChangeSpeadLimit() async {
    Get.find<Controllerdatabase>().UpdateDev();
    return 'GTMAX14__${(int.parse(SpeadLimit.value) - 40)}';
    //14
  }

  ChangeStartEnable(String value) {
    StartEnable.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
  }

  Future<String> ChangeLocationSendAfterFabric(bool value) async {
    LocationSendAfterFabric.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
    return 'GTMAX10__${value ? '1' : '99'}';
  }

  ChangeLocationSendAfterSms(String value) {
    LocationSendAfterSms.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
  }

  ChangeDoorpType(String value) {
    DoorpType.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
  }

  ChangeImpactIntensity(String value) {
    ImpactIntensity.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
  }

  ChangeShockAlarm() async {}

  Future<String> OffShoknumber() async {
    ShockNumber.value = '99';
    Get.find<Controllerdatabase>().UpdateDev();
    return 'GTMAX2__99';
  }

  Future<String> ChangeShockNumber() async {
    print('change shock alarm');
    int val = int.parse(ShockNumber.value);
    val = 99 - val;
    Get.find<Controllerdatabase>().UpdateDev();
    return 'GTMAX6__${val}';
  }
}
