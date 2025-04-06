import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerInfo.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Controllerreportsms extends GetxController {
  RxInt Lenght = 0.obs;
  RxList<RxString> Message = <RxString>[].obs;
  RxList<RxString> Date = <RxString>[].obs;
  RxString Type = ''.obs;
  RxBool FilterDate = false.obs;
  List<String> CopyMessage = <String>[];
  List<DateTime> CopyDate = <DateTime>[];
  Future<bool> GetMessages() async {
    /* SmsQuery query = SmsQuery();
    List<SmsMessage> messages = await query.querySms(
      address: '+98${Get.find<Controllerinfo>().Phone.value.substring(1)}',
    );
    Message = List.generate(messages.length, (i) => messages[i].body!.obs).obs;
    CopyMessage = List.generate(messages.length, (i) => messages[i].body!);
    CopyDate = List.generate(messages.length, (i) => messages[i].date!);
    Date = List.generate(
        messages.length, (i) => '${messages[i].date!.toPersianDate()}'.obs).obs;
    Lenght.value = messages.length; */
    return true;
  }

  FilteringDate(BuildContext context) async {
    if (FilterDate.value) {
      FilterDate.value = false;
      Message.value =
          List.generate(CopyMessage.length, (i) => CopyMessage[i].obs);
      Date.value = List.generate(
          CopyDate.length, (i) => '${CopyDate[i].toPersianDate()}'.obs);
      Lenght.value = CopyMessage.length;
    } else {
      var timenow = DateTime.now();
      int y =
          int.tryParse(timenow.toPersianDate().split('/')[0].toEnglishDigit())!;
      int m =
          int.tryParse(timenow.toPersianDate().split('/')[1].toEnglishDigit())!;
      var picked = await showPersianDateRangePicker(
        context: context,
        initialDateRange: JalaliRange(
          start: Jalali(y, m, 1),
          end: Jalali(y, m, 7),
        ),
        firstDate: Jalali(1385, 8),
        lastDate: Jalali(1450, 9),
      );
      if (picked != null) {
        FilterDate.value = true;
        DateTime TimeS = picked.start.toDateTime(),
            TimeE = picked.end.toDateTime();
        print('TimeS: ${TimeS} TimeE:${TimeE}');
        for (var i = 0; i < 20; i++) {
          print('Date ${i + 1}: ${CopyDate[i]}');
        }
        Message.value = [];
        Date.value = [];
        for (var i = 0; i < Lenght.value; i++) {
          if (TimeS.isBefore(CopyDate[i]) && TimeE.isAfter(CopyDate[i])) {
            print('yess');
            Message.add(CopyMessage[i].obs);
            Date.add('${CopyDate[i].toPersianDate()}'.obs);
          }
        }
        Lenght.value = Message.length;
        print('Lenght: ${Lenght.value}');
      }
    }
  }
}
