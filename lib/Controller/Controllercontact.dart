import 'package:flutter/widgets.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '/Controller/ControllerOther.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'ControllerDatabase.dart';

int lenghtContact = 4;

class Controllercontact extends GetxController {
  RxList<TextEditingController> TfName =
      List.generate(lenghtContact, (i) => TextEditingController()).obs;
  RxList<TextEditingController> TfPhone =
      List.generate(lenghtContact, (i) => TextEditingController()).obs;
  RxList<RxString> Level = List.generate(lenghtContact, (i) => 'QQQQQ'.obs).obs;
  RxList<RxString> Part = List.generate(lenghtContact, (i) => '1'.obs).obs;
  // RxList<RxInt> Index = List.generate(lenghtContact, (i) => 1.obs).obs;
  ////
  RxString ShowPart = ''.obs;
  RxBool MainContact = false.obs;
  RxList<int> List_Contact = <int>[].obs;

  ///
  Future<String> RegisterContact({int i = 0, String value = 'A'}) async {
    //Level[i].value = value;

    UpdateContact();
    String code = '';
    for (var i = 0; i < 26; i++) {
      if (TfPhone[i].text.length == 11) {
        code = code + '${i + 1}##${TfPhone[i].text}${Level[i].value}';
      }
    }
    ShowPart.value = '';
    return '${code}';
  }

  Future<String> AddOneContact(int i) async {
    String code = '';

    if (TfPhone[i].text.length == 11) {
      code = code + '${TfPhone[i].text}${Level[i].value}';
      UpdateContact();
    } else {
      Get.snackbar('خطا', 'طول شماره تلفن دستگاه باید 11 رقم باشد');
    }

    ShowPart.value = '';
    return '${i + 1}##${code}';
  }

  Future<String> ChangePart() async {
    String val = '';
    for (var i = 0; i < lenghtContact; i++) {
      val = val + Part[i].value;
    }
    UpdateContact();
    ShowPart.value = '';
    return 'LUXSWS$val';
  }

  Future<String> DeleteContact(int i) async {
    TfName[i].text = '';
    TfPhone[i].text = '';
    Level[i].value = 'QQQQQ';
    UpdateContact();
    String kk = '';
    for (var i = 0; i < 16; i++) {
      kk += 'k';
    }
    print(kk.length);
    return '${i + 1}##${kk}';
  }

  InquiryContact() {
    List<String> ListContact = Get.find<Controllerother>()
        .TextInuiry
        .value
        .substring(1)
        .replaceAll('#', '')
        .split('*');
    print(ListContact.length);
    for (var i = 0; i < ListContact.length; i++) {
      int j = 0;
      if (int.tryParse(ListContact[i].substring(0, 11)) != null) {
        j = int.parse(ListContact[i][ListContact[i].length - 1]);
      }
      j -= 1;
      if (int.tryParse(ListContact[i].substring(0, 11)) != null) {
        TfPhone[j].text = ListContact[i].substring(0, 11);

        Level[j].value = ListContact[i].substring(11, 16);
        print(
            'j: ${j + 1} ${ListContact[i].substring(0, 11)}  ${ListContact[i].substring(11, 16)}');
      }
      // List_Contact.add(j);
    }
    UpdateContact();
  }

  InquiryPart() {
    String message = Get.find<Controllerother>().TextInuiry.value;
    for (var i = 0; i < lenghtContact; i++) {
      Part[i].value = message[i];
    }
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    prefs.setBool('MainContact', true);
    MainContact.value = true;
    List_Contact.value = List.generate(lenghtContact, (i) => i);
    UpdateContact();
  }

  GetContact(String id) async {
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    List<String> copy_contact = await prefs.getStringList('${id}contact') ?? [];
    print('contact: ${copy_contact}');
    TfName.value = List.generate(
        lenghtContact,
        (i) => TextEditingController(
            text: copy_contact[i].split(CodeSplite)[0])).obs;
    TfPhone.value = List.generate(
        lenghtContact,
        (i) => TextEditingController(
            text: copy_contact[i].split(CodeSplite)[1])).obs;
    Level.value = List.generate(
        lenghtContact, (i) => copy_contact[i].split(CodeSplite)[2].obs).obs;

    Part.value = List.generate(
        lenghtContact, (i) => copy_contact[i].split(CodeSplite)[3].obs).obs;
    MainContact.value = await prefs.getBool('MainContact') ?? false;
    List<String> copylistcontact =
        await prefs.getStringList('${id}ListContact') ?? [];
    List_Contact.value = List.generate(
        copylistcontact.length, (i) => int.parse(copylistcontact[i]));
  }

  AddContact(String id) async {
    List<String> ValueContact = [];
    for (var i = 0; i < lenghtContact; i++) {
      ValueContact.add('$CodeSplite${CodeSplite}QQQQQ${CodeSplite}1');
    }

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();

    await prefs.setStringList('${id}contact', ValueContact);
  }

  SelectContact(int i) async {
    final FlutterContactPicker _contactPicker = new FlutterContactPicker();
    Contact? contact1 = await _contactPicker.selectContact();
    if (contact1 != null) {
      TfName[i].text = contact1.fullName.toString();
      TfPhone[i].text =
          contact1.phoneNumbers![0].replaceAll(' ', '').replaceAll('+98', '0');
    }
  }

  UpdateContact() async {
    List<String> valueContact = [];
    for (var i = 0; i < lenghtContact; i++) {
      valueContact.add(
          '${TfName[i].text}${CodeSplite}${TfPhone[i].text}${CodeSplite}${Level[i].value}${CodeSplite}${Part[i].value}');
    }

    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    await prefs.setStringList(
        '${Get.find<Controllerdatabase>().id.value}ListContact',
        List.generate(List_Contact.length, (i) => '${List_Contact[i]}'));
    await prefs.setStringList(
        '${Get.find<Controllerdatabase>().id.value}contact', valueContact);
  }

  Future<String> DeleteAllContact() async {
    await AddContact(Get.find<Controllerdatabase>().id.value);
    await GetContact(Get.find<Controllerdatabase>().id.value);
    return 'پاک شود';
  }
}
