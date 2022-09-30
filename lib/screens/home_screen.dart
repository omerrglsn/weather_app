import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/widgets/comfort_level.dart';
import 'package:weather_app/widgets/hourly_data_widget.dart';

import '../controller/global_controller.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/daily_data_forecast.dart';
import '../widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // call
  final GlobalController globalController = Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? Center(
                  child: Image.asset(
                    'assets/icons/clouds.png',
                    width: 200,
                    height: 200,
                  ),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(height: 20),
                      const HeaderWidget(),
                      // for our current temp (current)
                      CurrentWeatherWidget(weatherDataCurrent: globalController.getData().getCurrentWeather()),
                      const SizedBox(height: 20),
                      HourlyDataWidget(weatherDataHourly: globalController.getData().getHourlyWeather()),
                      const SizedBox(height: 20),
                      DailyDataForecast(weatherDataDaily: globalController.getData().getDailyWeather()),
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),
                      const SizedBox(height: 10),
                      ComfortLevel(weatherDataCurrent: globalController.getData().getCurrentWeather()),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
