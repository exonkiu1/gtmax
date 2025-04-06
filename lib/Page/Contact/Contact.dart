import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/Controllercontact.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../../Controller/ControllerOther.dart';
import '../../Core/SendOrder/OrderSms.dart';
import '../../Core/Widget/BackGroundView.dart';
import '../../Core/Widget/DecorationBox.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Backgroundview(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() {
                      return Visibility(
                        visible:
                            Get.find<Controllerother>().TypeInquiry.value !=
                                'Contact',
                        replacement: const CircularProgressIndicator(),
                        child: InkWell(
                          onTap: () => SendInquiry(
                              context,
                              () => Get.find<Controllercontact>()
                                  .InquiryContact(),
                              code: '0000L',
                              controller: '*',
                              type: 'Contact'),
                          child: Container(
                            width: Get.width * 0.3,
                            decoration: decoration(),
                            padding: const EdgeInsets.all(8),
                            child: const Center(
                              child: Text('استعلام مخاطبین'),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Column(
                  children:
                      List.generate(lenghtContact, (i) => WidgetContact(i: i))),
              InkWell(
                onTap: () => SendOrder(context,
                    () => Get.find<Controllercontact>().DeleteAllContact()),
                child: Container(
                  width: Get.width * 0.5,
                  decoration: decoration(),
                  padding: EdgeInsets.all(5),
                  child: Center(child: Text('حذف همه مخاطبین')),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class WidgetContact extends StatelessWidget {
  const WidgetContact({super.key, required this.i});
  final int i;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Container(
              width: Get.width,
              height: Get.width * 0.7,
              padding: EdgeInsets.only(top: Get.width * 0.067),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/contact/box 1.png'),
                      fit: BoxFit.fitHeight)),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: i == 0 ? false : true,
                              child: InkWell(
                                onTap: () => Get.find<Controllercontact>()
                                    .SelectContact(i),
                                child: const Icon(
                                  Icons.account_circle,
                                  color: Color.fromARGB(255, 221, 176, 75),
                                  size: 30,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Visibility(
                              visible: i == 0 ? false : true,
                              child: InkWell(
                                onTap: () => SendOrder(
                                    context,
                                    () => Get.find<Controllercontact>()
                                        .DeleteContact(i)),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: Get.width * 0.5,
                              padding: EdgeInsets.only(top: i == 0 ? 10 : 0),
                              child: Obx(() {
                                return TextField(
                                  controller:
                                      Get.find<Controllercontact>().TfName[i],
                                  enabled: i == 0 ? false : true,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText:
                                        (i != 0) ? 'نام مخاطب' : 'مالک اصلی',
                                    hintTextDirection: TextDirection.rtl,
                                    isDense: true,
                                  ),
                                  style: const TextStyle(fontSize: 12),
                                );
                              }),
                            ),
                            SizedBox(
                              width: Get.width * 0.5,
                              child: Obx(() {
                                return TextField(
                                  controller:
                                      Get.find<Controllercontact>().TfPhone[i],
                                  enabled: i == 0 ? false : true,
                                  keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                    hintText: 'شماره تلفن مخاطب',
                                    hintTextDirection: TextDirection.rtl,
                                    isDense: true,
                                  ),
                                  style: const TextStyle(fontSize: 12),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WidgetLevel(
                            Name: 'دسترسی خاموش کردن در تماس',
                            count: 1,
                            Value: 'L',
                            i: i,
                          ),
                          WidgetLevel(
                            Name: 'شنود',
                            count: 3,
                            Value: 'C',
                            i: i,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WidgetLevel(
                            Name: 'گزارشات',
                            Value: 'R',
                            count: 2,
                            i: i,
                          ),
                          WidgetLevel(
                            Name: 'اعلان حادثه',
                            Value: 'D',
                            count: 0,
                            i: i,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WidgetLevel(
                            Name: 'کنترل 1',
                            count: 4,
                            Value: 'A',
                            i: i,
                          ),
                          WidgetLevel(
                            Name: 'کنترل 2',
                            count: 4,
                            Value: 'B',
                            i: i,
                          )
                        ],
                      ),
                    ],
                  ),
                  Align(
                    child: Column(
                      children: [
                        Visibility(
                          visible: i == 0 ? false : true,
                          child: InkWell(
                              onTap: () => SendOrder(
                                  context,
                                  () => Get.find<Controllercontact>()
                                      .AddOneContact(i)),
                              child: Container(
                                width: Get.width * 0.4,
                                height: Get.width * 0.05,
                                //  color: Colors.red.withOpacity(0.2),
                              )),
                        ),
                        Container(
                          width: Get.width * 0.4,
                          height: Get.width * 0.05,
                          // color: Colors.red.withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        Align(
          child: Transform.translate(
            offset: Offset(10, 10),
            child: Container(
              height: 20,
              width: 20,
              child: Center(child: Text('${i + 1}'.toPersianDigit())),
            ),
          ),
        ),
      ],
    );
  }
}

class WidgetLevel extends StatelessWidget {
  const WidgetLevel(
      {super.key,
      required this.Name,
      this.Value = 'A',
      this.count = 0,
      this.i = 0});
  final String Name, Value;
  final int count, i;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (i != 0) {
          if (Get.find<Controllercontact>().Level[i].value.contains(Value)) {
            Get.find<Controllercontact>().Level[i].value =
                Get.find<Controllercontact>()
                    .Level[i]
                    .value
                    .replaceRange(count, count + 1, 'Q');
          } else {
            Get.find<Controllercontact>().Level[i].value =
                Get.find<Controllercontact>()
                    .Level[i]
                    .value
                    .replaceRange(count, count + 1, Value);
          }
        }
        //  Get.find<Controllercontact>().ShowPart.value = 'contact';
      },
      child: Obx(() {
        return Container(
          width: Get.width * 0.4,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
              color:
                  Get.find<Controllercontact>().Level[i].value.contains(Value)
                      ? const Color.fromARGB(107, 244, 67, 54)
                      : Color.fromARGB(107, 235, 211, 209),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              Name,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        );
      }),
    );
  }
}
