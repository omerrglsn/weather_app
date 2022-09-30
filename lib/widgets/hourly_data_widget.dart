// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/controller/global_controller.dart';
import 'package:weather_app/model/weather_data_hourly.dart';
import 'package:weather_app/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  HourlyDataWidget({super.key, required this.weatherDataHourly});

  // card index
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          alignment: Alignment.topCenter,
          child: const Text(
            'Today',
            style: TextStyle(fontSize: 16),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12 ? 14 : weatherDataHourly.hourly.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 80,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0.5, 0),
                      blurRadius: 30,
                      spreadRadius: 1,
                      color: CustomColors.dividerLine.withAlpha(150),
                    ),
                  ],
                  gradient: cardIndex.value == index
                      ? const LinearGradient(
                          colors: [
                            CustomColors.firstGradientColor,
                            CustomColors.secondGradientColor,
                          ],
                        )
                      : null,
                ),
                child: HourlyDetails(
                  index: index,
                  cardIndex: cardIndex.value,
                  temp: weatherDataHourly.hourly[index].temp!,
                  timeStamp: weatherDataHourly.hourly[index].dt!,
                  weatherIcon: weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// hourly details class

class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails({
    Key? key,
    required this.temp,
    required this.index,
    required this.cardIndex,
    required this.timeStamp,
    required this.weatherIcon,
  }) : super(key: key);

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(color: cardIndex == index ? Colors.white : CustomColors.textColorBlack),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(6),
          child: Image.asset(
            'assets/weather/$weatherIcon.png',
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            '$temp',
            style: TextStyle(color: cardIndex == index ? Colors.white : CustomColors.textColorBlack),
          ),
        )
      ],
    );
  }
}
