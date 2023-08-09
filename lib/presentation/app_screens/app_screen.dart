import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../recources/app_colors/app_colors.dart';
import '../recources/app_fonts/app_fonts.dart';

class WeatherApp extends StatelessWidget {
  List<WeekTemperatureModel> items = [
    WeekTemperatureModel(
        day: 'Monday', image: 'assets/images/sun.svg', min: '10', max: '10'),
    WeekTemperatureModel(
        day: 'Tuesday', image: 'assets/images/cloud.svg', min: '10', max: '10'),
    WeekTemperatureModel(
        day: 'Wednesday',
        image: 'assets/images/rain.svg',
        min: '10',
        max: '10'),
    WeekTemperatureModel(
        day: 'Thursday', image: 'assets/images/rain.svg', min: '10', max: '10'),
    WeekTemperatureModel(
        day: 'Friday', image: 'assets/images/snow.svg', min: '10', max: '10'),
  ];

  WeatherApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();

    Color gradientStartColor;
    Color gradientEndColor;
    String image;

    if (currentTime.hour >= 6 && currentTime.hour < 12) {
      gradientStartColor = AppColors.bgRed;
      gradientEndColor = AppColors.bgYellow;
      image = 'assets/images/bigSun.svg';
    } else if (currentTime.hour >= 12 && currentTime.hour < 18) {
      gradientStartColor = AppColors.bgDayStart;
      gradientEndColor = AppColors.bgDayEnd;
      image = 'assets/images/bigSun.svg';
    } else {
      gradientStartColor = AppColors.bgNightStart;
      gradientEndColor = AppColors.bgNightEnd;
      image = 'assets/images/moon.svg';
    }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 30,
                    width: 170,
                    child: const TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'San Francisco',
                    style: AppFonts.w400s36.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Clear',
                    style: AppFonts.w400s24.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(image),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '11',
                    style: AppFonts.w700s72.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'May XX, 20XX',
                    style: AppFonts.w400s22.copyWith(color: AppColors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, index) {
                      return WeekTemperature(
                        model: items[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeekTemperature extends StatelessWidget {
  final WeekTemperatureModel model;
  const WeekTemperature({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              model.day,
              style: AppFonts.w400s20.copyWith(color: AppColors.white),
            ),
          ),
          SvgPicture.asset(model.image),
          const SizedBox(
            width: 100,
          ),
          Text(
            model.min,
            style: AppFonts.w400s20.copyWith(color: AppColors.white),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            model.max,
            style: AppFonts.w400s20.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}

class WeekTemperatureModel {
  String day;
  String image;
  String min;
  String max;
  WeekTemperatureModel(
      {required this.day,
      required this.image,
      required this.min,
      required this.max});
}
