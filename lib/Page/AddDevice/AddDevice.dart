import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerInfo.dart';
import '/Controller/ControllerOther.dart';
import '/Core/Widget/DecorationBox.dart';
import '/Page/SettingSim/SettingSim.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Widget.dart' as widget;

TextEditingController tf_name = TextEditingController(),
    tf_phone = TextEditingController();

class Adddevice extends StatefulWidget {
  const Adddevice({super.key});

  @override
  State<Adddevice> createState() => _AdddeviceState();
}

class _AdddeviceState extends State<Adddevice> {
  @override
  void initState() {
    Get.find<Controllerinfo>().GetShowSelectedSim();
    CheckPermisionSms();
    // TODO: implement initState
    super.initState();
  }

  CheckPermisionSms() async {
    var status = await Permission.sms.status;
    if (status.isDenied) {
      await Permission.sms.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WidgetTextField(
                    hint: 'نام دستگاه',
                    tf: tf_name,
                  ),
                  WidgetTextField(
                    hint: 'شماره تلفن دستگاه',
                    tf: tf_phone,
                    keyint: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            widget.WidgetSelectedSim(),
            InkWell(
              onTap: () => Get.find<Controllerdatabase>().AddDev(),
              child: Container(
                width: Get.width * 0.4,
                decoration: decoration(),
                child: Center(
                  child: Text('ثبت دستگاه'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetTextField extends StatelessWidget {
  const WidgetTextField(
      {super.key, required this.hint, this.keyint = false, required this.tf});
  final String hint;
  final bool keyint;
  final TextEditingController tf;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.4,
      child: TextField(
        controller: tf,
        onChanged: (value) {
          if (keyint) {
            if (value.length == 11) {
              String oproator = FindOprator(value);
              if (oproator == '') {
                SelectedOprator();
              } else {
                Get.find<Controllerother>().Oprator.value = oproator;
              }
            }
          }
        },
        keyboardType: keyint ? TextInputType.phone : null,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }
}

SelectedOprator() {
  Get.bottomSheet(
      Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonOprator(Name: 'ایرانسل', value: 'ir'),
                  ButtonOprator(Name: 'همراه اول', value: 'ha'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonOprator(Name: 'رایتل', value: 'rl'),
                  ButtonOprator(Name: 'شاتل', value: 'sh'),
                ],
              ),
            ),
          ],
        ),
      ),
      isDismissible: false);
}

class ButtonOprator extends StatelessWidget {
  const ButtonOprator({super.key, required this.Name, required this.value});
  final String Name, value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<Controllerother>().Oprator.value = value;
        Get.back();
      },
      child: Container(
        width: Get.width * 0.3,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          Name,
          style: TextStyle(color: Colors.black),
        )),
      ),
    );
  }
}
