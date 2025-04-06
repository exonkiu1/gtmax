import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import '/Controller/ControllerHistory.dart';
import '/Controller/ControllerMapOnline.dart';
import '/Core/Widget/Map/ControllerMap.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' as math;

LatLng latLnginit = const LatLng(36.32685365584436, 59.49704296352605);

class Widgetmap extends StatefulWidget {
  const Widgetmap({super.key});

  @override
  State<Widgetmap> createState() => _WidgetmapState();
}

class _WidgetmapState extends State<Widgetmap> {
  @override
  void initState() {
    Get.find<Controllermap>().dispos.value = false;
    Get.find<Controllermap>().ChangeAuto();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.find<Controllermap>().dispos.value = true;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: latLnginit,
        initialZoom: 10,
        onPositionChanged: (camera, hasGesture) {
          Get.find<Controllermap>().CounterMove.value += 1;
          Get.find<Controllermap>().auto.value = false;
          Get.find<Controllermap>().Zoom.value = mapController.camera.zoom;
        },
        onPointerHover: (event, point) {
          print(event.localPosition);
        },
        onTap: (tapPosition, point) {},
        onMapEvent: (p0) {},
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        Obx(() {
          return Visibility(
            visible: !Get.find<Controllermaponline>().Maponline.value
                ? false
                : false,
            child: Obx(() {
              return PolylineLayer(polylines: [
                Polyline(
                    points: List.generate(
                        Get.find<Controllerhistory>().LenghtList.value, (i) {
                      if (double.tryParse(Get.find<Controllerhistory>()
                                  .Location[i]
                                  .split(',')[0]
                                  .removeAllWhitespace) !=
                              null &&
                          double.tryParse(Get.find<Controllerhistory>()
                                  .Location[i]
                                  .split(',')[1]
                                  .removeAllWhitespace) !=
                              null) {
                        return LatLng(
                            double.parse(Get.find<Controllerhistory>()
                                .Location[i]
                                .split(',')[0]
                                .removeAllWhitespace),
                            double.parse(Get.find<Controllerhistory>()
                                .Location[i]
                                .split(',')[1]
                                .removeAllWhitespace));
                      } else {
                        return LatLng(
                            double.parse(Get.find<Controllerhistory>()
                                .Location[i - 1]
                                .split(',')[0]
                                .removeAllWhitespace),
                            double.parse(Get.find<Controllerhistory>()
                                .Location[i - 1]
                                .split(',')[1]
                                .removeAllWhitespace));
                      }
                    }),
                    color: Color.fromARGB(141, 200, 54, 244).withOpacity(0.3),
                    strokeWidth: 7)
              ]);
            }),
          );
        }),
        Obx(() {
          return MarkerLayer(markers: [
            Marker(
                height: 45,
                width: 45,
                point: LatLng(Get.find<Controllermap>().X.value,
                    Get.find<Controllermap>().Y.value),
                /*    width: Get.width * 0.5,
                height: Get.width * 0.2, */
                child: Obx(() {
                  return Transform.rotate(
                    angle: Get.find<Controllermap>().degree_car.value *
                        (math.pi / 180),
                    child: Image.asset(
                      'assets/image/map/car3.png',
                      height: 45,
                    ),
                  );
                })),
            Marker(
              width: Get.width * 0.5,
              height: 80,
              point: LatLng(Get.find<Controllermap>().X.value,
                  Get.find<Controllermap>().Y.value),
              alignment: Alignment.topCenter,
              child: Obx(() {
                return Visibility(
                  visible: Get.find<Controllerhistory>().ShowStopCar.value,
                  child: Container(
                    width: Get.width * 0.4,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey),
                    child: Column(
                      children: [
                        Text('میزان توقف'),
                        Text(
                            '${Get.find<Controllerhistory>().DurationTimeStop.value}'
                                .substring(0, 8))
                      ],
                    ),
                  ),
                );
              }),
            ),
          ]);
        })
      ],
    );
  }
}
