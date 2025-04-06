import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../Controller/ControllerInquiry.dart';
import '../../Core/Widget/BackGroundView.dart';
import '../../Core/Widget/DecorationBox.dart';

class Reportsms extends StatefulWidget {
  const Reportsms({super.key});

  @override
  State<Reportsms> createState() => _ReportsmsState();
}

class _ReportsmsState extends State<Reportsms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Backgroundview(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () =>
                  Get.find<Controllerreportsms>().FilteringDate(context),
              child: Obx(() {
                return Container(
                  width: Get.width * 0.4,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: decoration(
                      color: Get.find<Controllerreportsms>().FilterDate.value),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('بازه زمانی'),
                      Obx(() {
                        return Visibility(
                            visible: Get.find<Controllerreportsms>()
                                .FilterDate
                                .value,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ));
                      })
                    ],
                  )),
                );
              }),
            ),
            FutureBuilder(
                future: Get.find<Controllerreportsms>().GetMessages(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: Get.height * 0.82,
                      child: SingleChildScrollView(
                        child: Obx(() {
                          return Column(
                            children: List.generate(
                                Get.find<Controllerreportsms>().Lenght.value,
                                (i) => BoxMessage(
                                      i: i,
                                    )),
                          );
                        }),
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        )),
      ),
    );
  }
}

class BoxMessage extends StatelessWidget {
  const BoxMessage({super.key, required this.i});
  final int i;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      padding: EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: decoration(),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Text(Get.find<Controllerreportsms>().Message[i].value)),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                Get.find<Controllerreportsms>().Date[i].value,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
