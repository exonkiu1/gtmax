import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/Controller/Binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.grey,
      theme: ThemeData.dark(),
      /* ThemeData(
          scaffoldBackgroundColor: Colors.grey[900],
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white, fontFamily: 'A'),
            bodySmall: TextStyle(color: Colors.white, fontFamily: 'A'),
            bodyLarge: TextStyle(color: Colors.white, fontFamily: 'A'),
          ),
          sliderTheme: SliderThemeData(
            activeTrackColor: Colors.amber,
            thumbColor: Color.fromARGB(255, 40, 40, 5),
          )),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
          sliderTheme: SliderThemeData(
        thumbColor: Colors.red,
      )), */
      initialBinding: mybinding(),
      home: const Scaffold(
        body: Center(
          child: Text(
            'GtMax',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}

String CodeSplite = '?^^?';
