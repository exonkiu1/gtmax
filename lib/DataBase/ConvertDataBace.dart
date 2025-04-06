import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

String Vars = """
  String id;
  String Phone;
  String Name;
  String Oprator;
  String IdDev;
  String PassUser;
  String StateInternet;
  String StateDev;
  String SpeadDifference;
  String SpeadLimit; 
  String StartEnable;
  String LocationSendAfterFabric; 
  String LocationSendAfterSms; 
  String DoorpType; 
  String ImpactIntensity; 
  String ShockAlarm; 
  String ShockNumber;  
  String Vehicle; 
  String ChildrenLock; 
  String SencorsTime; 
  String StartPositionSend;
""";
String Var3 = """
  String SpeadDifference;
  String SpeadLimit; 
  String StartEnable;
  String LocationSendAfterFabric; 
  String LocationSendAfterSms; 
  String DoorpType; 
  String ImpactIntensity; 
  String ShockAlarm; 
  String ShockNumber;  
  String Vehicle; 
  String ChildrenLock; 
  String SencorsTime; 
  String StartPositionSend;
""";
SplitVars(String value) {
  String CreateDataBace = '', ToString = '';

  value = value.replaceAll('\n', '');
  for (var i = 0; i < value.split('String').length; i++) {
    CreateDataBace = CreateDataBace +
        '${value.split('String ')[i].removeAllWhitespace.replaceAll(';', ' TEXT')},';
    String tostring =
        value.split('String ')[i].replaceAll(';', '').removeAllWhitespace;
    ToString = ToString + '${tostring}:' + r'$' + '${tostring},';
  }
  print('ToString:${ToString}');
  print('CrateDatabace:${CreateDataBace}');
}

String TEXTonCreate =
    'id TEXT,Phone TEXT,Name TEXT,Oprator TEXT,IdDev TEXT,PassUser TEXT,StateInternet TEXT,StateDev TEXT,SpeadDifference TEXT,SpeadLimit TEXT,StartEnable TEXT,LocationSendAfterFabric TEXT,LocationSendAfterSms TEXT,DoorpType TEXT,ImpactIntensity TEXT,ShockAlarm TEXT,ShockNumber TEXT,Vehicle TEXT,ChildrenLock TEXT,SencorsTime TEXT,StartPositionSend TEXT';
String TEXTrxstring = '';
String TEXTFUNC = '';
String TextUpdate = '';
String? TEXTFUNCVAR;
controllervars(String value) {
  TEXTrxstring = '';
  TEXTFUNC = '';
  TextUpdate = '';
  TEXTFUNCVAR = '';

  value = value.replaceAll('\n', '');
  for (var i = 0; i < value.split('String').length; i++) {
    String tostring =
        value.split('String ')[i].replaceAll(';', '').removeAllWhitespace;
    TEXTrxstring =
        TEXTrxstring + 'RxString ' + tostring + '''= ''.obs ''' + ';';
    TEXTFUNC = TEXTFUNC + tostring + '.value = ' + 'model.' + tostring + ';';
    TextUpdate = TextUpdate +
        tostring +
        ':' +
        'Get.find<Controllersetting>().' +
        tostring +
        '.value,';
    TEXTFUNCVAR = TEXTFUNCVAR! +
        'Change' +
        tostring +
        '(String value){' +
        '${tostring}.value=value;' +
        'Get.find<Controllerdatabase>().UpdateDev();}';
  }
  print(TEXTFUNCVAR);
}
