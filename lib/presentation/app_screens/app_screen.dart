import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/consts.dart';
import 'package:weather_app/core/weather_model.dart';

import '../recources/app_colors/app_colors.dart';
import '../recources/app_fonts/app_fonts.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({
    super.key,
  });

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

String city = '';
String weatherType = '';
String image = '';
String temperature = '';
String weatherIcon = 'https://openweathermap.org/img/wn/10d@2x.png';
String cityName = '';
String? errorText;

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

    Color gradientStartColor;
    Color gradientEndColor;

    if (currentTime.hour >= 6 || currentTime.hour < 12) {
      gradientStartColor = AppColors.bgRed;
      gradientEndColor = AppColors.bgYellow;
    } else if (currentTime.hour >= 12 && currentTime.hour < 18) {
      gradientStartColor = AppColors.bgDayStart;
      gradientEndColor = AppColors.bgDayEnd;
    } else {
      gradientStartColor = AppColors.bgNightStart;
      gradientEndColor = AppColors.bgNightEnd;
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        if (value.isEmpty) {
                          errorText = null;
                        }
                        setState(() {});
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        errorText: errorText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            getData(cityName = controller.text);
                          },
                          icon: Icon(Icons.search),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    city,
                    style: AppFonts.w400s36.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    weatherType,
                    style: AppFonts.w400s24.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(weatherIcon),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    temperature,
                    style: AppFonts.w700s72.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    formattedDate,
                    style: AppFonts.w400s22.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getData(String cityName) async {
    final Dio dio = Dio();
    try {
      final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          "q": cityName,
          "appid": AppConsts.apiKey,
          "units": 'metric',
          "lang": 'ru',
        },
      );
      final model = WeatherModel.fromJson(response.data);
      city = model.name ?? '';
      weatherType = model.weather?.first.description ?? '';
      image = model.weather?.first.icon ?? '';
      temperature = model.main?.temp?.round().toString() ?? '';
      weatherIcon = 'https://openweathermap.org/img/wn/$image@2x.png';

      setState(() {});
    } catch (e) {
      errorText = 'Не верный город, проверьте запрос';
    }
  }
}
