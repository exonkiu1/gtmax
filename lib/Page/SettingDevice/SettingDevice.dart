import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerDatabase.dart';
import '/Controller/ControllerSetting.dart';
import '/Core/SendOrder/OrderSms.dart';
import '/Core/Widget/DecorationBox.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class Settingdevice extends StatelessWidget {
  const Settingdevice({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              WidgetShokAlarm(),
              WidgetStateSendLocationAfterOrderSms(),
              WidgetLocationSendAfterFabric(),
              InkWell(
                onTap: () => SendOrder(
                    context, () => Get.find<Controllerdatabase>().ReSetDev2()),
                child: Container(
                  width: Get.width * 0.9,
                  decoration: decoration(),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Icon(Icons.refresh), Text('ریست دستگاه')],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetLocationSendAfterFabric extends StatelessWidget {
  const WidgetLocationSendAfterFabric({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: decoration(),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Text('ارسال موقعیت بعد از قفل باز با ریموت'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => SendOrder(
                    context,
                    () => Get.find<Controllersetting>()
                        .ChangeLocationSendAfterFabric(true)),
                child: Obx(() {
                  return Container(
                    width: Get.width * 0.3,
                    decoration: decoration(
                        color: Get.find<Controllersetting>()
                            .LocationSendAfterFabric
                            .value),
                    child: Center(child: Text('فعال')),
                  );
                }),
              ),
              InkWell(
                onTap: () => SendOrder(
                    context,
                    () => Get.find<Controllersetting>()
                        .ChangeLocationSendAfterFabric(false)),
                child: Obx(() {
                  return Container(
                    width: Get.width * 0.3,
                    decoration: decoration(
                        color: !Get.find<Controllersetting>()
                            .LocationSendAfterFabric
                            .value),
                    child: Center(child: Text('غیرفعال')),
                  );
                }),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WidgetStateSendLocationAfterOrderSms extends StatelessWidget {
  const WidgetStateSendLocationAfterOrderSms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: decoration(),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Text('ارسال موقعیت بعد از هر دستور پیامکی'),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => SendOrder(
                    context,
                    () => Get.find<Controllersetting>()
                        .ChangeStateSendLocationAfterSms(true)),
                child: Obx(() {
                  return Container(
                    width: Get.width * 0.3,
                    decoration: decoration(
                        color: Get.find<Controllersetting>()
                            .StateSendLocationAfterSms
                            .value),
                    child: Center(child: Text('فعال')),
                  );
                }),
              ),
              InkWell(
                onTap: () => SendOrder(
                    context,
                    () => Get.find<Controllersetting>()
                        .ChangeStateSendLocationAfterSms(false)),
                child: Obx(() {
                  return Container(
                    width: Get.width * 0.3,
                    decoration: decoration(
                        color: !Get.find<Controllersetting>()
                            .StateSendLocationAfterSms
                            .value),
                    child: Center(child: Text('غیرفعال')),
                  );
                }),
              )
            ],
          )
        ],
      ),
    );
  }
}

class WidgetTypeAlarmSpead extends StatelessWidget {
  const WidgetTypeAlarmSpead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: decoration(),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: Column(
        children: [
          Text('نوع اعلان سرعت غیر مجاز'),
          Obx(() {
            return DropdownButton(
                value: Get.find<Controllersetting>().TypeAlarmSpead.value,
                items: List.generate(AlarmTypeSpead.length,
                        (i) => AlarmTypeSpead.keys.elementAt(i))
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    child: Text(
                      value,
                    ),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) => SendOrder(
                    context,
                    () => Get.find<Controllersetting>()
                        .ChangeAlarmSpead(value!)));
          })
        ],
      ),
    );
  }
}

class WidgetCheckBox extends StatelessWidget {
  const WidgetCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(child: Image.asset('assets/image/widget/ring.png')),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Text('تماس و پیامک'),
                SizedBox(
                    width: Get.width * 0.6,
                    child: Image.asset('assets/image/widget/road.png'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetSpeadDifference extends StatelessWidget {
  const WidgetSpeadDifference({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      decoration: decoration(),
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Text('حداکثر سرعت خطرناک'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => SendOrder(
                    context,
                    () =>
                        Get.find<Controllersetting>().ChangeSpeadDifference()),
                child: Container(
                  width: Get.width * 0.3,
                  decoration: decoration(),
                  child: Center(
                    child: Text('اعمال'),
                  ),
                ),
              ),
              Row(
                children: [
                  Obx(() {
                    return Slider(
                        value: int.parse(Get.find<Controllersetting>()
                                .SpeadDifference
                                .value)
                            .toDouble(),
                        min: int.parse(
                                Get.find<Controllersetting>().SpeadLimit.value)
                            .toDouble(),
                        max: 180,
                        onChanged: (value) {
                          Get.find<Controllersetting>().SpeadDifference.value =
                              '${value.toInt()}';
                        });
                  }),
                  SizedBox(
                    width: 30,
                    child: Obx(() {
                      return Text(
                          Get.find<Controllersetting>().SpeadDifference.value);
                    }),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class WidgetSpeadLimit extends StatelessWidget {
  const WidgetSpeadLimit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: decoration(),
      child: Column(
        children: [
          Text('حداکثر سرعت مجاز'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => SendOrder(
                  context,
                  () => Get.find<Controllersetting>().ChangeShockAlarm(),
                ),
                child: Container(
                  width: Get.width * 0.3,
                  decoration: decoration(),
                  child: Center(
                    child: Text('اعمال'),
                  ),
                ),
              ),
              Row(
                children: [
                  Obx(() {
                    return Slider(
                        value: int.parse(
                                Get.find<Controllersetting>().SpeadLimit.value)
                            .toDouble(),
                        min: 50,
                        max: 180,
                        onChanged: (value) {
                          Get.find<Controllersetting>().SpeadLimit.value =
                              '${value.toInt()}';
                        });
                  }),
                  SizedBox(
                    width: 30,
                    child: Obx(() {
                      return Text(
                          Get.find<Controllersetting>().SpeadLimit.value);
                    }),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class WidgetShokAlarm extends StatelessWidget {
  const WidgetShokAlarm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: decoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => SendOrder(context,
                    () => Get.find<Controllersetting>().OffShoknumber()),
                child: Container(
                  width: Get.width * 0.3,
                  decoration: decoration(),
                  child: Center(
                    child: Text('غیرفعال کردن'),
                  ),
                ),
              ),
              Text('شدت ضربه به خودرو'.toPersianDigit())
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => SendOrder(
                  context,
                  () => Get.find<Controllersetting>().ChangeShockNumber(),
                ),
                child: Container(
                  width: Get.width * 0.3,
                  decoration: decoration(),
                  child: Center(
                    child: Text('اعمال'),
                  ),
                ),
              ),
              Row(
                children: [
                  Obx(() {
                    return Slider(
                        value: int.tryParse(Get.find<Controllersetting>()
                                    .ShockNumber
                                    .value) !=
                                null
                            ? int.parse(Get.find<Controllersetting>()
                                    .ShockNumber
                                    .value)
                                .toDouble()
                            : 30.0,
                        min: 1,
                        max: 99,
                        onChanged: (value) {
                          Get.find<Controllersetting>().ShockNumber.value =
                              '${value.toInt()}';
                        });
                  }),
                  Obx(() {
                    return Text(
                        Get.find<Controllersetting>().ShockNumber.value);
                  })
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

Map<String, int> AlarmTypeSpead = {
  'تماس و پیامک': 1,
  'پیامک': 2,
  'تماس': 3,
  'غیرفعال': 4,
  'پیامک اگر اختلاف تجاوز سرعت رد شد تماس': 6
};
