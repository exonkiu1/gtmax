import 'package:telephony/telephony.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../Controller/ControllerInfo.dart';
import '../../Controller/ControllerOther.dart';

void SendOrder(BuildContext context, Future<String> Function() function,
    {String title = 'هشدار',
    String description = 'پیامک به دستگاه ارسال شود؟',
    bool PassDev = false,
    bool StateInternet = false}) {
  print('object');
  showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                title,
                textAlign: TextAlign.center,
              ),
              content: Text(
                description,
                textDirection: TextDirection.rtl,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  child: Text('لغو'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    String code = await function();
                    print('code : $code');
                    //SendSms(code);
                    SendSms(code);
                    Get.snackbar('هشدار', 'پیامک ارسال شد');
                  },
                  child: Text('تایید'),
                ),
              ],
            );
          })
      /* : Get.snackbar(
          'توجه',
          'لطفا تا دستور بعدی 10 ثانیه صبر کنید',
          backgroundColor: Color.fromARGB(255, 45, 38, 38),
        ) */
      ;
}

DirectOrder(
  Future<String> Function() function,
) async {
  String code = await function();
  print('code : $code');
  //SendSms(code);
  SendSms(code);
  Get.snackbar('هشدار', 'پیامک ارسال شد');
}

void DirectInquiry(Function() function,
    {String code = '',
    String controller = '',
    String type = '',
    bool Audio = true}) async {
  Get.find<Controllerother>().TypeInquiry.value = type;
  await SendSms(code, check: false);
  InquirySms(
    function,
    controller: controller,
  );
}

SendSms(String code, {bool check = true}) async {
  print('phone :${Get.find<Controllerinfo>().Phone.value} ${code}');
  final Telephony telephony = Telephony.instance;
  telephony.sendSms(
    to: '${Get.find<Controllerinfo>().Phone.value}',
    message: '${code}',
    subscriptionId: Get.find<Controllerinfo>().simcard.value,
  );
  if (check) {
    Get.find<Controllerother>().ResiveSmsDev.value = true;
    await Future.delayed(Duration(seconds: 2));
    Get.find<Controllerother>().ResiveSmsDev.value = false;
    //  CheckResiveSms(code);
  }
}

CheckResiveSms(String code) {
  Get.find<Controllerother>().StartTimeCheck(code);
  final telephony = Telephony.instance;
  telephony.listenIncomingSms(
    onNewMessage: (SmsMessage message) {
      if (message.address!
          .contains(Get.find<Controllerinfo>().Phone.value.substring(3, 8))) {
        Get.find<Controllerother>().TypeInquiry.value = '';
        Get.find<Controllerother>().ResiveSmsDev.value = true;
        Get.find<Controllerother>().TextInuiry.value = message.body!;
        Get.find<Controllerother>().TextInuiry.value = message.body!;
      } else {
        print(message.address);
      }
    },
    listenInBackground: false,
  );
}

DialogTextFieldSms(BuildContext context, Function() function,
    {String title = 'توجه',
    String description = '',
    int maxlenght = 50,
    bool KeyboardInt = false,
    bool sms = false}) {
  Get.find<Controllerother>().tf.text = '';
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            title,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                description + ' ' + 'وارد کنید',
              ),
              TextField(
                autofocus: true,
                controller: Get.find<Controllerother>().tf,
                maxLength: maxlenght,
                keyboardType: KeyboardInt ? TextInputType.number : null,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('لغو'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                String code = '';
                if (sms) {
                  code = await function();
                } else {
                  function();
                }

                if (sms) {
                  SendSms(code);
                }

                print('code : $code');
              },
              child: Text('تایید'),
            ),
          ],
        );
      });
}

void InquirySms(
  Function() function, {
  String controller = '',
}) {
  final telephony = Telephony.instance;
  telephony.listenIncomingSms(
    onNewMessage: (SmsMessage message) {
      if (message.address!
          .contains(Get.find<Controllerinfo>().Phone.value.substring(2, 7))) {
        if (message.body!.contains(controller) == true) {
          Get.find<Controllerother>().TypeInquiry.value = '';
          Get.snackbar('توجه', 'استعلام رسید');
          Get.find<Controllerother>().TextInuiry.value = message.body!;
          function();
          Get.find<Controllerother>().TextInuiry.value = message.body!;
        }
      }
    },
    listenInBackground: false,
  );
}

SendInquiry(BuildContext context, Function() function,
    {String title = 'هشدار',
    String description =
        'یکی از مراحل استعلام را انتخاب نمایید(ابتدا باید پیامک به دستگاه ارسال شود)',
    String code = '',
    String controller = '',
    String type = ''}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('لغو'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                Get.find<Controllerother>().TypeInquiry.value = type;
                SendSms(code, check: false);
                InquirySms(
                  function,
                  controller: controller,
                );
                print('code : $code');
              },
              child: Text('ارسال پیامک'),
            ),
          ],
        );
      });
}

///

