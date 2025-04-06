import 'package:get/get.dart';

import 'package:get/get_rx/get_rx.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerOther.dart';

import '../DataBase/Model.dart';

class Controllerinfo extends GetxController {
  @override
  void onInit() {
    //GetShowSelectedSim();
    // TODO: implement onInit
    super.onInit();
  }

  RxString Name = ''.obs;
  RxString Phone = ''.obs;
  RxString Oprator = ''.obs;
  RxInt simcard = 0.obs;
  RxBool ShowSelectedSim = true.obs;
  GetInfo(Car model) {
    Name.value = model.Name;
    Phone.value = model.Phone;
    Oprator.value = model.Oprator;
    simcard.value = int.parse(model.simcard);
  }

  GetShowSelectedSim() async {
    /*  final Telephony telephony = Telephony.instance;
    List listsimcard = await telephony.sim();
    if (listsimcard.length > 1) {
      ShowSelectedSim.value = true;
    } else {
      ShowSelectedSim.value = false;
    } */
  }

  ChangeName() {
    Name.value = Get.find<Controllerother>().tf.text;
    Get.find<Controllerdatabase>().UpdateDev();
  }

  ////
  ChangePhone() {
    Phone.value = Get.find<Controllerother>().tf.text;
    Oprator.value = FindOprator(Phone.value);
    Get.find<Controllerdatabase>().UpdateDev();
  }
}

///////
///
///
///
///
String FindOprator(String phone) {
  String oprator = '';
  if (ha.contains(phone.substring(0, 4))) {
    oprator = 'ha';
  }
  if (rl.contains(phone.substring(0, 4))) {
    oprator = 'rl';
  }
  if (ir.contains(phone.substring(0, 4))) {
    oprator = 'ir';
  }
  return oprator;
}

Map<String, String> codeInquiryCharge = {
  'ha': '*140*11#',
  'ir': '*555*1*2#',
  'rl': '*200*2*2*1#',
};
List<String> ha = [
  '0910',
  '0911',
  '0912',
  '0913',
  '0914',
  '0915',
  '0916',
  '0917',
  '0918',
  '0919',
  '0990',
  '0991',
  '0992',
  '0993',
  '0996',
];

List<String> ir = [
  '0930',
  '0933',
  '0935',
  '0936',
  '0937',
  '0938',
  '0939',
  '0901',
  '0902',
  '0903',
  '0904',
  '0905',
];

List<String> rl = [
  '0920',
  '0921',
  '0922',
];
