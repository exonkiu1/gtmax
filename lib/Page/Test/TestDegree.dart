import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerMapOnline.dart';
import '/Core/Widget/Map/ControllerMap.dart';
import '/Core/Widget/Map/WidgetMap.dart';

class Testdegree extends StatefulWidget {
  const Testdegree({super.key});

  @override
  State<Testdegree> createState() => _TestdegreeState();
}

class _TestdegreeState extends State<Testdegree> {
  @override
  void initState() {
    Get.find<Controllermaponline>().Maponline.value = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          for (var i = 0; i < ListLoctations.length; i++) {
            await Future.delayed(Duration(milliseconds: 100));
            Get.find<Controllermap>().GetXY(text: ListLoctations[i]);
          }
        },
      ),
      body: Stack(
        children: [Widgetmap()],
      ),
    );
  }
}
