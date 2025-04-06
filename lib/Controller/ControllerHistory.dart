import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerInternet.dart';
import '/Core/Widget/KM/ControllerKm.dart';
import '/Core/Widget/Map/ControllerMap.dart';
import '/main.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'ControllerMapOnline.dart';

/* 5996
a000 */
class Controllerhistory extends GetxController {
  ReadHistory() async {
    await Hive.initFlutter();
    await Hive.openBox('${Get.find<Controllerdatabase>().id.value}history');
    var box = Hive.box('${Get.find<Controllerdatabase>().id.value}history');
    return box.get('history');
  }

  AddToHistory({String text = ''}) async {
    print('start AddToHistory');
    await Hive.initFlutter();
    await Hive.openBox('${Get.find<Controllerdatabase>().id.value}history');
    var box = Hive.box('${Get.find<Controllerdatabase>().id.value}history');
    await box.put('history', text);
    print('end AddToHistory');
  }

  GetFile() async {
    String url =
        // 'https://webappluxsecurity.ir/test.txt';
        'http://h5q.ir/api/webapi/GetClientG_BackUp?id=${Get.find<Controllerinternet>().Id.value}${Get.find<Controllerinternet>().Pass.value}qerr12.123456,98.765432';
    print('Url: ${url}');
    Dio dio = Dio();
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getTemporaryDirectory();
        final filepath = '${directory.path}/file.text';
        final file = File(filepath);
        await file.writeAsBytes(response.bodyBytes);
        String NewValue = await file.readAsString();
        print('Value File: ${NewValue}');
        if (NewValue.contains('"There is NO new report"')) {
          print('no add Data');
        } else {
          /* NewValue =
              NewValue.split('There is NO new report')[1].replaceAll('"', ''); */
          List<String> Listfile = NewValue.split(r'\r\n');
          Listfile.removeAt(0);

          NewValue = '';
          print('List New ListFile:${Listfile.sublist(0, 5)}');

          for (var i = 0; i < Listfile.length; i++) {
            NewValue = NewValue + Listfile[i] + CodeSplite;
          }
          print('NEwVALUE 00 : ${NewValue.substring(0, 50)}');
          String Value = await ReadHistory() ?? '';
          Value = Value + NewValue;
          print('VALUE 00 : ${Value.substring(0, 50)}');
          await AddToHistory(text: Value);
        }
      }
    } catch (e) {}

    //
  }

  ///
  RxList<String> Location = <String>[].obs;
  RxList<int> Spead = <int>[].obs;
  RxList<String> Time = <String>[].obs;
  RxList<DateTime> Date = <DateTime>[].obs;
  RxString TimeLast = ''.obs;
  RxString DateLast = ''.obs;
  RxBool ShowFilterTime = false.obs;
  RxBool ShowTextDate = false.obs;
  RxDouble MinSlider = 0.0.obs;
  RxDouble MaxSlider = 0.0.obs;
  Removechar() async {
    print('start');
    String value = await ReadHistory() ?? '';
    List<String> ListValue = value.split(r'\r\n');

    if (value != '') {
      for (var i = 0; i < ListValue.length; i++) {
        if (ListValue[i].length > 35) {
          print(i);
          ListValue.removeAt(i);

          print('yes');
        }
      }
      String Value1 = '';
      for (var i = 0; i < ListValue.length; i++) {
        Value1 = Value1 + ListValue[i];
      }
      // AddToHistory(Value1);
    }
    print('end');
  }

  GetHistory({int Start = 0, int End = 0}) async {
    String value =
        //await rootBundle.loadString('assets/file2.txt');
        await ReadHistory() ?? '';
    print('GetHistory ');
    if (value != '') {
      List<String> ListValue = value.split(CodeSplite);
      print('lenght old:${ListValue.length}');

      for (var i = 0; i < ListValue.length; i++) {
        if (ListValue[i].split(':').length != 2 ||
            !ListValue[i].contains(':')) {
          ListValue.removeAt(i);
        }
      }
      for (var i = 0; i < ListValue.length; i++) {
        if (ListValue[i].split(':').length != 2 ||
            !ListValue[i].contains(':')) {
          ListValue.removeAt(i);
        }
      }
      for (var i = 0; i < ListValue.length; i++) {
        if (ListValue[i].split(':').length != 2 ||
            !ListValue[i].contains(':')) {
          print('yess');
        }
      }
/*       print('new Lengh: ${ListValue.length}');
      print('ControllerHistory: ${ListValue.sublist(0, 3)}'); */
      if (End != 0) {
        ListValue = ListValue.sublist(Start, End);
        MinSlider.value = Start.toDouble();
        MaxSlider.value = End.toDouble();
        print('filtering');
      } else {
        MaxSlider.value = ListValue.length.toDouble();
        MinSlider.value = 0;
      }

      LenghtList.value = ListValue.length;
      CountPlay.value = Start;
      print(
          'Start: ${MinSlider.value} / End: ${MaxSlider.value} /Lenght: ${LenghtList.value}');
      Location =
          List.generate(ListValue.length, (i) => ListValue[i].split(':')[1])
              .obs;
      Spead.value = List.generate(
          ListValue.length,
          (i) =>
              (CompreserCode.indexOf(ListValue[i][0]) * 64) +
              CompreserCode.indexOf(ListValue[i][1])).obs;
      Time.value = List.generate(
          ListValue.length,
          (i) =>
              '${CompreserCode.indexOf(ListValue[i][2])}:${CompreserCode.indexOf(ListValue[i][3])}:${CompreserCode.indexOf(ListValue[i][4])}');

      Date.value = List.generate(
        ListValue.length,
        (i) => DateTime(
            DateTime.now().year,
            CompreserCode.indexOf(ListValue[i][5]),
            CompreserCode.indexOf(ListValue[i][6]),
            CompreserCode.indexOf(ListValue[i][2]),
            CompreserCode.indexOf(ListValue[i][3]),
            CompreserCode.indexOf(ListValue[i][4])),
      );
      DateLast.value = Date[ListValue.length - 1].toPersianDate();
      TimeLast.value = Time[ListValue.length - 1];
      Duration difrense = Date[ListValue.length - 1].difference(Date[0]);
      if (End == 0) {
        if (difrense.inDays >= 1) {
          SearchYesterday(
              Date[ListValue.length - 1].subtract(Duration(days: 1)));
        }
      }
      print('End GetHistory');
    } else {
      print('no DATA');
    }
  }

  SearchYesterday(DateTime time) {
    for (var i = 0; i < LenghtList.value; i++) {
      if (time.isBefore(Date[i])) {
        print('Search YesterDay:${i}');
        CountPlay.value = i;
        break;
      }
    }
  }

  /////
  RxInt CountPlay = 0.obs;
  RxInt LenghtList = 0.obs;
  RxDouble XSpead = 1.0.obs;
  RxBool Pause = true.obs;
  RxString TimeNow = ''.obs;
  RxString DateNow = ''.obs;
  RxDouble timecar = 0.1.obs;
  RxBool ShowStopCar = false.obs;
  RxString DurationTimeStop = '1234567890'.obs;

  PlayCar(BuildContext context) async {
    if (LenghtList.value > 3) {
      print('Play Car');
      TimeNow.value = Time[0];
      DateNow.value = Date[0].toPersianDate();
      while (!Get.find<Controllermaponline>().Maponline.value) {
        await Future.delayed(
            Duration(milliseconds: ((timecar * 1000) / XSpead.value).toInt()));
        if ((MaxSlider.value - 2) > CountPlay.value) {
          if (!Pause.value) {
            if ((MaxSlider.value - 1) > CountPlay.value) {
              CountPlay.value += 1;
            }
          }
          StopingCar();
          Get.find<Controllermap>().GetXY(text: Location[CountPlay.value]);
          Get.find<Controllerkm>().calculateSequence(Spead[CountPlay.value]);
          TimeNow.value = Time[CountPlay.value];
          DateNow.value = Date[CountPlay.value].toPersianDate();
        } else {
          Pause.value = true;
        }

        if (Get.find<Controllermap>().dispos.value) {
          CountPlay.value = 0;
          XSpead.value = 1.0;
          Pause.value = false;
          break;
        }
      }
      print('Dispose History');
    }
  }

  StopingCar() {
    if (Spead[CountPlay.value] == 0) {
      Get.find<Controllerkm>().calculateSequence(0);
      int IndexSpead = 0;
      while (true) {
        if ((CountPlay.value + IndexSpead) < (MaxSlider.value - 1)) {
          if (Spead[CountPlay.value + IndexSpead] != 0) {
            break;
          }
        } else {
          Pause.value = true;
          CountPlay.value = MinSlider.value.toInt();
          break;
        }

        IndexSpead += 1;
      }

      DurationTimeStop.value =
          '${Date[CountPlay.value + IndexSpead].difference(Date[CountPlay.value])}';
      print(
          'Time Stop: ${Date[CountPlay.value + IndexSpead].difference(Date[CountPlay.value])} ,Start:${Date[CountPlay.value]}  End:${Date[CountPlay.value + IndexSpead]}');
      ShowStopCar.value = true;
      timecar.value = 3;
      if ((CountPlay.value + IndexSpead) < (MaxSlider.value - 2)) {
        CountPlay.value += IndexSpead;
      }

      IndexSpead = 0;
    } else {
      ShowStopCar.value = false;
      timecar.value = 0.1;
    }
  }

  RxInt Year_S = 2025.obs,
      Month_S = 11.obs,
      Day_S = 14.obs,
      Hour_S = 0.obs,
      Minute_S = 0.obs,
      Year_E = 2025.obs,
      Month_E = 11.obs,
      Day_E = 14.obs,
      Hour_E = 0.obs,
      Minute_E = 0.obs;
  RxBool FilteringDate = false.obs;
  FilterDate(BuildContext context) async {
    var picked = await showPersianDateRangePicker(
      context: context,
      firstDate: Jalali(1403, 12),
      lastDate: Jalali(1450, 9),
    );
    int start = 0, end = 0;
    if (picked != null) {
      ShowFilterTime.value = true;
      FilteringDate.value = true;
      await GetHistory();
      DateTime startTime = picked.start.toDateTime(),
          endTime = picked.end.toDateTime();
      //
      Year_S.value = startTime.year;
      Month_S.value = startTime.month;
      Day_S.value = startTime.day;

      ///
      Year_E.value = endTime.year;
      Month_E.value = endTime.month;
      Day_E.value = endTime.day;
      Hour_E.value = 24;
      ProcessFiltering();
    }
  }

  ProcessFiltering() {
    DateTime? StartTime, EndTime;
    StartTime = DateTime(
        Year_S.value, Month_S.value, Day_S.value, Hour_S.value, Minute_S.value);
    EndTime = DateTime(
        Year_E.value, Month_E.value, Day_E.value, Hour_E.value, Minute_E.value);
    int? start, end;
    for (var i = 0; i < LenghtList.value; i++) {
      if (StartTime.isBefore(Date[i])) {
        print(
            'EN: (${i}) ${Date[i]} VS ${StartTime}  PR: ${Date[i].toPersianDate()} VS ${StartTime.toPersianDate()}');
        start = i;
        break;
      }
    }
    for (var i = 0; i < LenghtList.value; i++) {
      if (EndTime.isAfter(Date[i])) {
        end = i;
      } else {
        print(
            'END0 EN: (${i}) ${Date[i - 1]} VS ${EndTime}  PR: ${Date[i - 1].toPersianDate()} VS ${EndTime.toPersianDate()}');
        print(
            'END1 EN: (${i}) ${Date[i]} VS ${EndTime}  PR: ${Date[i].toPersianDate()} VS ${EndTime.toPersianDate()}');
        print(
            'END2 EN: (${i}) ${Date[i + 1]} VS ${EndTime}  PR: ${Date[i + 1].toPersianDate()} VS ${EndTime.toPersianDate()}');

        break;
      }
    }

    print('start:${start} end:${end} lengh:${LenghtList.value}');

    Get.find<Controllerhistory>().GetHistory(Start: (start!), End: (end!));
  }

  ///
  ///
  ///
  RxString TimeStart = ''.obs, TimeEnd = ''.obs;
  FilterTime(BuildContext context, {bool Start = false}) async {
    var pic = await showPersianTimePicker(
        context: context, initialTime: TimeOfDay.now());
    if (pic != null) {
      print(pic);
      if (Start) {
        Hour_S.value = pic.hour;
        Minute_S.value = pic.minute;
        TimeStart.value = '${pic.hour}:${pic.minute}';
      } else {
        Hour_E.value = pic.hour;
        Minute_E.value = pic.minute;
        TimeEnd.value = '${pic.hour}:${pic.minute}';
      }
      ProcessFiltering();
    }
  }

  DeleteTime({bool Start = true}) {
    if (Start) {
      Hour_S.value = 0;
      Minute_S.value = 0;
      TimeStart.value = '';
    } else {
      Hour_E.value = 0;
      Minute_E.value = 0;
      TimeEnd.value = '';
    }
    ProcessFiltering();
  }

  ClearDate() {
    FilteringDate.value = false;
    GetHistory();
  }

  NextPervious({bool Next = true}) {
    if (Next) {
      if ((CountPlay.value + 100) <= LenghtList.value) {
        CountPlay.value += 100;
      }
    } else {
      if ((CountPlay.value - 100) != 0) {
        CountPlay.value -= 100;
      }
    }
  }
}

String CompreserCode =
    "abcdefghijklmnopqrstuvwxyz,0123456789_ABCDEFGHIJKLMNOPQRSTUVWXYZ";
