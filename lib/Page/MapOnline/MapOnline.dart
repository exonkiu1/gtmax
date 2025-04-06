import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerMapOnline.dart';
import '/Core/SendOrder/OrderSms.dart';
import '/Core/Widget/KM/WidgetKm.dart';
import '/Core/Widget/Map/ControllerMap.dart';
import '/Core/Widget/Map/WidgetMap.dart';

class Maponline extends StatelessWidget {
  const Maponline({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Align(child: Widgetmap()),
          Align(
            alignment: Alignment.topRight,
            child: WidgetZoom(),
          ),

          /* Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Obx(() {
                return Text(
                  '${Get.find<Controllermaponline>().TextStateInternet.value}',
                  style: TextStyle(color: Colors.black),
                );
              }),
            ),
          ), */
          Align(alignment: Alignment.bottomCenter, child: WidgetKM()),
        ],
      ),
    );
  }
}

class WidgetZoom extends StatelessWidget {
  const WidgetZoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          ButtonZoom(
            StateZoom: true,
            icon: Icons.add,
          ),
          ButtonZoom(
            StateZoom: false,
            icon: Icons.remove,
          ),
          InkWell(
            onTap: () => Get.find<Controllermap>().BackToLoc(),
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(85, 33, 149, 243)),
              child: Center(child: Icon(Icons.refresh)),
            ),
          ),
          InkWell(
            onTap: () => DirectInquiry(
                () => Get.find<Controllermaponline>().GetLocsms(),
                code: 'موقعیت'),
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(85, 33, 149, 243)),
              child: Center(child: Icon(Icons.signal_cellular_off_outlined)),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonZoom extends StatelessWidget {
  const ButtonZoom({super.key, required this.StateZoom, required this.icon});
  final IconData icon;
  final bool StateZoom;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<Controllermap>().ZoomMap(ZoomIn: StateZoom);
      },
      onLongPress: () {
        Get.find<Controllermap>().ZoomMap(ZoomIn: StateZoom, longpress: true);
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(85, 33, 149, 243)),
        child: Center(child: Icon(icon)),
      ),
    );
  }
}
