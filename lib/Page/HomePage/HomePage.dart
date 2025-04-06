import 'package:telephony/telephony.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/ControllerHomepage.dart';
import '/Controller/ControllerStateDev.dart';
import '/Page/MapOnline/MapOnline.dart';
import '../../Core/Widget/KM/WidgetKm.dart';
import '../Options/Options.dart' as page;
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static const platform = MethodChannel('com.example.app/sms');
  Future<void> _sendSMS(String phoneNumber, String message, int simSlot) async {
    try {
      await platform.invokeMethod('sendSMS', {
        'phoneNumber': phoneNumber,
        'message': message,
        'simSlot': simSlot,
      });
    } on PlatformException catch (e) {
      print("Failed to send SMS: '${e.message}'.");
    }
  }

  @override
  void initState() {
    Get.find<Controllerhomepage>().IntroHomePage();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
          child: Icon(Icons.text_snippet),
          onPressed: () async {
            final Telephony telephony = Telephony.instance;
            telephony.sendSms(
              to: '09922993653',
              message: 'hello',
              subscriptionId: 1,
            );
            // _sendSMS("09922993653", "سلام! این یک پیام تست است.", 0);
          }), */
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/homepage/bg.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Obx(() {
                    return Image.asset(
                        'assets/image/homepage/car/${Get.find<Controllerhomepage>().LightCar.value}${Get.find<Controllerhomepage>().ModelCar.value}.png');
                  }),
                ),
                Container(
                  width: Get.width,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/image/homepage/item.png',
                        width: Get.width,
                        fit: BoxFit.fitWidth,
                      ),
                      Align(
                        child: SizedBox(
                          width: Get.width * 0.8,
                          height: Get.height * 0.12,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: InkWell(
                                      onTap: () => Get.to(() => Maponline()),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        // color: const Color.fromARGB(108, 244, 67, 54),
                                      ),
                                    )),
                                Expanded(
                                    flex: 6,
                                    child: InkWell(
                                      onTap: () =>
                                          Get.find<Controllerstatedev>()
                                              .StartStop(context),
                                      child: Container(
                                          //  color: const Color.fromARGB(93, 255, 235, 59),
                                          ),
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: InkWell(
                                      onTap: () => Get.to(() => page.Options()),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        //  color: const Color.fromARGB(98, 0, 0, 0),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const WidgetKM(),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Transform.translate(
                offset: Offset(-30, Get.height * 0.1),
                child: InkWell(
                  onTap: () => Get.find<Controllerhomepage>().Listener(),
                  child: Image.asset(
                    'assets/image/homepage/telephone.png',
                    height: 65,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
