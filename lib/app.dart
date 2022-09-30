import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      home: HomeScreen(),
    );
  }
}
