import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerHistory.dart';
import '/Controller/ControllerMapOnline.dart';
import '/Core/Widget/KM/WidgetKm.dart';
import '/Core/Widget/Map/ControllerMap.dart';
import '/Core/Widget/Map/WidgetMap.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    Get.find<Controllermaponline>().Maponline.value = false;
    gethistory();
    // TODO: implement initState
    super.initState();
  }

  void gethistory() async {
    Get.find<Controllermaponline>().Maponline.value = false;
    await Get.find<Controllerhistory>().GetFile();
    await Get.find<Controllerhistory>().GetHistory();
/*     Get.find<Controllerhistory>()
        .GetHistory(End: Get.find<Controllerhistory>().LenghtList.value - 1); */
    Get.find<Controllerhistory>().PlayCar(context);
  }

  @override
  void dispose() {
    Get.find<Controllermaponline>().Maponline.value = true;
    Get.find<Controllermap>().dispos.value = true;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Align(
            child: Widgetmap(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: const WidgetKM(),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: PlayerHistory(),
          ),
        ],
      ),
    );
  }
}

class PlayerHistory extends StatelessWidget {
  const PlayerHistory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width * 0.9,
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color.fromARGB(135, 158, 158, 158),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (Get.find<Controllerhistory>().Pause.value) {
                        Get.find<Controllerhistory>().Pause.value = false;
                      } else {
                        Get.find<Controllerhistory>().Pause.value = true;
                      }
                    },
                    child: Obx(() {
                      return Icon(
                        Get.find<Controllerhistory>().Pause.value
                            ? Icons.play_arrow
                            : Icons.pause,
                      );
                    }),
                  ),
                  SizedBox(
                    width: Get.width * 0.7,
                    child: Obx(() {
                      return Slider(
                          value: Get.find<Controllerhistory>()
                              .CountPlay
                              .value
                              .toDouble(),
                          max: Get.find<Controllerhistory>()
                              .MaxSlider
                              .value
                              .toDouble(),
                          min: Get.find<Controllerhistory>().MinSlider.value,
                          onChanged: (value) {
                            Get.find<Controllerhistory>().CountPlay.value =
                                value.toInt();
                            Get.find<Controllerhistory>().timecar.value = 0.1;
                          });
                    }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Obx(() {
                        return Text(
                            Get.find<Controllerhistory>().TimeNow.value);
                      }),
                      Obx(() {
                        return Text(
                            Get.find<Controllerhistory>().DateNow.value);
                      })
                    ],
                  ),
                  Obx(() {
                    return DropdownButton(
                        value: Get.find<Controllerhistory>().XSpead.value,
                        items: [
                          0.3,
                          0.5,
                          0.7,
                          1.0,
                          1.2,
                          1.5,
                          1.7,
                          2.0,
                          2.5,
                          3.0,
                          4.0
                        ]
                            .map<DropdownMenuItem<double>>((double value) =>
                                DropdownMenuItem(
                                    value: value, child: Text('${value}')))
                            .toList(),
                        onChanged: (value) {
                          Get.find<Controllerhistory>().XSpead.value = value!;
                        });
                  }),
                  Row(
                    children: [
                      InkWell(
                          onTap: () => Get.find<Controllerhistory>()
                              .NextPervious(Next: false),
                          child: const Icon(Icons.skip_previous)),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () => Get.find<Controllerhistory>()
                              .NextPervious(Next: true),
                          child: const Icon(Icons.skip_next)),
                    ],
                  ),
                  Column(
                    children: [
                      Obx(() {
                        return Text(
                            Get.find<Controllerhistory>().TimeLast.value);
                      }),
                      Obx(() {
                        return Text(
                            Get.find<Controllerhistory>().DateLast.value);
                      })
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => Get.find<Controllerhistory>().FilterDate(context),
                child: Container(
                  width: Get.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('فیلتر تاریخ'),
                        Obx(() {
                          return Visibility(
                            visible: Get.find<Controllerhistory>()
                                .FilteringDate
                                .value,
                            child: InkWell(
                              onTap: () =>
                                  Get.find<Controllerhistory>().ClearDate(),
                              child: const InkWell(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: Get.find<Controllerhistory>().ShowFilterTime.value,
                  child: Container(
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey),
                    child: Center(
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () => Get.find<Controllerhistory>()
                                  .FilterTime(context, Start: true),
                              child: const Text('فیلتر ساعت شروع')),
                          Obx(() {
                            return Visibility(
                              visible: Get.find<Controllerhistory>()
                                      .TimeStart
                                      .value !=
                                  '',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() {
                                    return Text(Get.find<Controllerhistory>()
                                        .TimeStart
                                        .value);
                                  }),
                                  InkWell(
                                    onTap: () => Get.find<Controllerhistory>()
                                        .DeleteTime(Start: true),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Obx(() {
                return Visibility(
                  visible: Get.find<Controllerhistory>().ShowFilterTime.value,
                  child: Container(
                    width: Get.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey),
                    child: Center(
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () => Get.find<Controllerhistory>()
                                  .FilterTime(context, Start: false),
                              child: const Text('فیلتر ساعت پایان')),
                          Obx(() {
                            return Visibility(
                              visible:
                                  Get.find<Controllerhistory>().TimeEnd.value !=
                                      '',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() {
                                    return Text(Get.find<Controllerhistory>()
                                        .TimeEnd
                                        .value);
                                  }),
                                  InkWell(
                                    onTap: () => Get.find<Controllerhistory>()
                                        .DeleteTime(Start: false),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        )
      ],
    );
  }
}
