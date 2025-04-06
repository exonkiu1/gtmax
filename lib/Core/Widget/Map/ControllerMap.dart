import 'dart:ffi';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';

MapController mapController = MapController();

class Controllermap extends GetxController {
  RxDouble X = 0.0.obs, Y = 0.0.obs;
  RxDouble Zoom = 16.0.obs;
  RxInt CounterMove = 0.obs;
  RxBool auto = true.obs;
  RxBool dispos = false.obs;
  ChangeAuto() async {
    print('start');
    while (true) {
      await Future.delayed(Duration(milliseconds: 15));
      if (CounterMove.value > 0) {
        if (CounterMove.value > 1000) {
          CounterMove.value -= 10;
        } else {
          CounterMove.value -= 1;
        }
      } else {
        if (!auto.value) {
          auto.value = true;
          BackToLoc();
        }
      }
      if (dispos.value) {
        break;
      }
    }
    print('end');
  }

  ZoomMap({bool ZoomIn = true, bool longpress = false}) {
    if (ZoomIn) {
      if (longpress) {
        Zoom.value += 3.0;
      } else {
        Zoom.value += 1.0;
      }
    } else {
      if (longpress) {
        Zoom.value -= 3.0;
      } else {
        Zoom.value -= 1.0;
      }
    }
    mapController.move(mapController.camera.center, Zoom.value);
  }

  BackToLoc() {
    /*   X.value = 36.32685365584436;
    Y.value = 59.49704296352605; */
    mapController.move(LatLng(X.value, Y.value), Zoom.value);
  }

  ///////////////////
  RxDouble degree_car = 0.0.obs;
  RxDouble P_X = 0.0.obs, P_Y = 0.0.obs;
  GetXY({String text = ''}) {
    try {
      X.value = double.parse(text.split(',')[0].replaceAll(' ', ''));
      Y.value = double.parse(text.split(',')[1].replaceAll(' ', ''));
      if (X.value != P_X.value && Y.value != P_Y.value) {
        degree_car.value =
            calculateBearing(P_X.value, P_Y.value, X.value, Y.value);
      }

      P_X.value = X.value;
      P_Y.value = Y.value;
      // print('X:${X.value}Y:${Y.value}');
    } catch (e) {
      print('XY${e}');
    }
    if (auto.value) {
      mapController.move(LatLng(X.value, Y.value), Zoom.value);
    }
  }
}

double calculateBearing(double lat1, double lon1, double lat2, double lon2) {
  double lat1Rad = radians(lat1);
  double lon1Rad = radians(lon1);
  double lat2Rad = radians(lat2);
  double lon2Rad = radians(lon2);

  double dLon = lon2Rad - lon1Rad;

  double y = sin(dLon) * cos(lat2Rad);
  double x =
      cos(lat1Rad) * sin(lat2Rad) - sin(lat1Rad) * cos(lat2Rad) * cos(dLon);
  double bearing = atan2(y, x);

  bearing = degrees(bearing);

  bearing = (bearing + 360) % 360;

  return bearing;
}

double radians(double degrees) {
  return degrees * pi / 180;
}

double degrees(double radians) {
  return radians * 180 / pi;
}

List<String> ListLoctations = [
  '36.3712284417836,59.49076772364691',
  '36.3713215693235,59.49060194587011',
  '36.3713991755219,59.49044773398498',
  '36.37148919861497,59.49031279858616',
  '36.37148919861497,59.49031279858616', //
  '36.37148919861497,59.49031279858616', //
  '36.37148919861497,59.49031279858616', //
  '36.37159474261824,59.49012774454337',
  '36.371703390892094,59.489942690280316',
  '36.3717468501595,59.489881005526684',
  '36.3717468501595,59.489881005526684', //
  '36.3717468501595,59.489881005526684', //
  '36.3717468501595,59.489881005526684', //
  '36.3717468501595,59.489881005526684', //
  '36.37185860244969,59.48969980656153',
  '36.371933103886704,59.48956487116271',
  '36.37207279389037,59.48931427684917',
  '36.37218764775395,59.48914079039301',
  '36.37249496330102,59.48856635302326',
  '36.37249496330102,59.48856635302326', //
  '36.37249496330102,59.48856635302326', //
  '36.37249496330102,59.48856635302326', //
  '36.37249496330102,59.48856635302326', //
  '36.372675006514044,59.4882887725889',
  '36.37278985578173,59.48809215709926',
  '36.3728519395752,59.48799191937405',
  '36.372951273541176,59.487803009814144',
  '36.37298541956261,59.48772975916896',
  '36.37315925362087,59.487444467181774',
  '36.37315925362087,59.487444467181774', //
  '36.37315925362087,59.487444467181774', //
  '36.37315925362087,59.487444467181774', //
  '36.373277212224735,59.487274834108206',
  '36.37341689981385,59.48703580568625',
  '36.37347898310695,59.48692785736745',
  '36.37347898310695,59.48692785736745', //
  '36.37347898310695,59.48692785736745', //
  '36.37347898310695,59.48692785736745', //
  '36.373528649704994,59.486873883207465',
  '36.373547274671566,59.48681219845383',
  '36.37360314929391,59.486719671724245',
  '36.373693169836486,59.486565459839085',
  '36.373792502727355,59.486403537360275',
  '36.373879418903726,59.486249325475114',
  '36.37396323083833,59.48612210066992',
  '36.37396323083833,59.48612210066992', //
  '36.37396323083833,59.48612210066992', //
  '36.37396323083833,59.48612210066992', //
  '36.37398806284452,59.4861105362466',
  '36.37402531255228,59.485979456144605',
  '36.374180519477136,59.485740427722675',
  '36.374363661747054,59.48548597997416'
];
