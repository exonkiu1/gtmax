class Car {
  //// V1
  String id;
  String Phone;
  String Name;
  String Oprator;
  String IdDev;
  String PassUser;
  String StateInternet;
  //// V2
  String StateDev;
  //// V3
  String SpeadDifference; // اختلاف سرعت غیر مجاز
  String SpeadLimit; // سرعت غیرمجاز
  String StartEnable; // اجازه روشن شدن خودرو
  String
      LocationSendAfterFabric; // ارسال موقعیت گوگل مپ بعد از قفل باز با ریموت
  String LocationSendAfterSms; // ارسال موقعیت گوگل مپ بعد از قفل باز با پیامک
  String DoorpType; // تنظیم لایه داری مثبت
  String ImpactIntensity; // حساسیت  شوک سنسور
  String ShockAlarm; // حالت اعلان شوک سنسور
  String ShockNumber; //
  String Vehicle; // نوع وسیله نقلیه
  String ChildrenLock; // قفل کودک
  String SencorsTime;
  String StartPositionSend; // ارسال موقعیت خودرو بعد از روشن شدن
  //// v4
  String ModelCar;

  /// v5
  String UrgentOpreation;

  /// v6
  String TypeAlarmSpead;

  /// v7
  String StateSendLocationAfterSms; //9
  /// v8
  String simcard;
  Car(
      {required this.id,
      required this.Name,
      required this.Phone,
      required this.Oprator,
      this.ModelCar = 'بوگاتی',
      this.PassUser = '',
      this.IdDev = '',
      this.StateInternet = 'false',
      this.StateDev = 'قفل',
      this.ChildrenLock = '', //
      this.DoorpType = '',
      this.ImpactIntensity = '',
      this.LocationSendAfterFabric = '',
      this.LocationSendAfterSms = '',
      this.SencorsTime = '',
      this.ShockAlarm = '',
      this.ShockNumber = '90',
      this.SpeadDifference = '180',
      this.SpeadLimit = '50',
      this.StartEnable = '',
      this.Vehicle = '',
      this.StartPositionSend = '',
      this.UrgentOpreation = 'خاموش',
      this.TypeAlarmSpead = 'تماس و پیامک',
      this.StateSendLocationAfterSms = 'true',
      this.simcard = '-1'});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Phone': Phone,
      'Name': Name,
      'Oprator': Oprator,
      'IdDev': IdDev,
      'PassUser': PassUser,
      'StateInternet': StateInternet,
      'StateDev': StateDev,
      'ChildrenLock': ChildrenLock,
      'DoorpType': DoorpType,
      'ImpactIntensity': ImpactIntensity,
      'LocationSendAfterFabric': LocationSendAfterFabric,
      'LocationSendAfterSms': LocationSendAfterSms,
      'SencorsTime': SencorsTime,
      'ShockAlarm': ShockAlarm,
      'ShockNumber': ShockNumber,
      'SpeadDifference': SpeadDifference,
      'SpeadLimit': SpeadLimit,
      'StartEnable': StartEnable,
      'Vehicle': Vehicle,
      'StartPositionSend': StartPositionSend,
      'ModelCar': ModelCar,
      'UrgentOpreation': UrgentOpreation,
      'TypeAlarmSpead': TypeAlarmSpead,
      'StateSendLocationAfterSms': StateSendLocationAfterSms,
      'simcard': simcard
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Car{id:$id,Phone:$Phone,Name:$Name,Oprator:$Oprator,IdDev:$IdDev,PassUser:$PassUser,StateInternet:$StateInternet,StateDev:$StateDev,SpeadDifference:$SpeadDifference,SpeadLimit:$SpeadLimit,StartEnable:$StartEnable,LocationSendAfterFabric:$LocationSendAfterFabric,LocationSendAfterSms:$LocationSendAfterSms,DoorpType:$DoorpType,ImpactIntensity:$ImpactIntensity,ShockAlarm:$ShockAlarm,ShockNumber:$ShockNumber,Vehicle:$Vehicle,ChildrenLock:$ChildrenLock,SencorsTime:$SencorsTime,StartPositionSend:$StartPositionSend,ModelCar:$ModelCar,UrgentOpreation:$UrgentOpreation,TypeAlarmSpead:$TypeAlarmSpead,StateSendLocationAfterSms:$StateSendLocationAfterSms,simcard:$simcard}';
  }
}
