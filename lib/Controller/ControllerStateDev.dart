import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerHomepage.dart';
import '/Core/SendOrder/OrderSms.dart';
import '/Core/Widget/DecorationBox.dart';
import '/DataBase/Model.dart';

class Controllerstatedev extends GetxController {
  RxString StateDev = 'باز'.obs;
  RxInt Degree = 0.obs;
  RxString UrgentOpreation = ''.obs;
  GetStateDev(Car model) {
    StateDev.value = model.StateDev;
    if (MapStateDev[model.StateDev] != null) {
      Degree.value = MapStateDev[model.StateDev]!['degree'];
    } else {
      Degree.value = MapStateDev['قفل']!['degree'];
    }
    UrgentOpreation.value = model.UrgentOpreation;
  }

  StartStop(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Center(child: Text('عملیات فوری')),
            actions: [
              WidgetStateStartStop(
                title: 'روشن',
                code: 'روشن',
              ),
              WidgetStateStartStop(
                title: 'خاموش فوری',
                code: 'خاموش',
              ),
              WidgetStateStartStop(
                title: 'خاموش آرام',
                code: 'خاموش آرام',
              )
            ],
          );
        });
  }

  ChangeStartStop(String value, BuildContext context) async {
    UrgentOpreation.value = value;
    Get.find<Controllerdatabase>().UpdateDev();
    Navigator.of(context).pop();
    SendSms(value);
  }

  Future<String> ChangeStateDev(String value) async {
    StateDev.value = value;
    rotataDegree(value);
    /*  switch (value) {
      case 'قفل':
        Get.find<Controllerhomepage>().PlayStateOn();
        break;
      case 'قفل سایلنت':
        Get.find<Controllerhomepage>().PlayStateOnSilent();
      default:
        Get.find<Controllerhomepage>().PlayStateOff();
    } */
    Get.find<Controllerdatabase>().UpdateDev();
    return value;
  }

  rotataDegree(String value) async {
    int degree = MapStateDev[value]!['degree'];
    int copy_degree = Degree.value;
    while (degree != Degree.value) {
      await Future.delayed(Duration(milliseconds: 20));
      if (degree > Degree.value) {
        Degree.value += 1;
      } else {
        Degree.value -= 1;
      }
    }
  }
}

class WidgetStateStartStop extends StatelessWidget {
  const WidgetStateStartStop(
      {super.key, required this.title, required this.code});
  final String title;
  final String code;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.find<Controllerstatedev>().ChangeStartStop(code, context),
      child: Obx(() {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: decoration(
            color:
                Get.find<Controllerstatedev>().UrgentOpreation.value == title,
          ),
          child: Center(
              child: Text(
            title,
            style: TextStyle(color: Colors.white),
          )),
        );
      }),
    );
  }
}

Map<String, Map<String, dynamic>> MapStateDev = {
  'باز': {
    'degree': 43,
    'code': '',
  },
  'قفل': {
    'degree': 120,
    'code': '',
  },
  'قفل سایلنت': {
    'degree': 185,
    'code': '',
  },
  'صندوق': {
    'degree': 0,
    'code': '',
  },
  'GT00': {
    'degree': 230,
    'code': '',
  },
};
