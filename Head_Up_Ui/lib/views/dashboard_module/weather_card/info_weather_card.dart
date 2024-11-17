import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:head_up_ui/bloc/current_weather_bloc/current_weather_condition_bloc.dart';
import 'package:head_up_ui/model/current_weather_condition.dart';
import 'package:head_up_ui/model/current_weather_model.dart';
import 'package:head_up_ui/model/nearest_area.dart';
import 'package:head_up_ui/views/shared/clock.dart';
import 'package:head_up_ui/views/shared/skeleton.dart';

class InfoWeatherCard extends StatefulWidget {

  final bool isDarkMode;

  InfoWeatherCard(this.isDarkMode);

  @override
  State<StatefulWidget> createState() => InfoWeatherCardState();
}

class InfoWeatherCardState extends State<InfoWeatherCard> {
  final CurrentWeatherConditionBloc _currentWeatherConditionBloc =
      CurrentWeatherConditionBloc();

  late String selectedCity = "Ho Chi Minh City";

  late bool isLoading = true;

  late bool isDarkMode;

  late CurrentWeatherModel currentWeather;

  final skeletonWeatherData =
      CurrentWeatherModel(CurrentCondition.demoData, NearestArea.sampleData);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("is Dark : ${widget.isDarkMode}");
    isDarkMode = widget.isDarkMode;
    _currentWeatherConditionBloc.eventController.sink
        .add(GetCurrentWeatherConditionEvent(selectedCity));
  }

  @override
  void didUpdateWidget(covariant InfoWeatherCard oldWidget) {
    // TODO: implement didUpdateWidget
    setState(() {
      isDarkMode = widget.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<CurrentWeatherConditionState>(
        stream: _currentWeatherConditionBloc.stateController.stream,
        initialData: _currentWeatherConditionBloc.state,
        builder: (context, AsyncSnapshot<CurrentWeatherConditionState> snap) {
          var weatherState;
          if (snap.data is LoadCurrentWeatherConditionState) {
            weatherState = snap.data;
            currentWeather = weatherState?.currentCondition;
            setStateOutOfBuildPhrase(() {
              isLoading = false;
            });
          } else {
            setStateOutOfBuildPhrase(() {
              isLoading = true;
            });
          }
          return isLoading
              ? Skeleton(detailCard(skeletonWeatherData))
              : detailCard(currentWeather);
        });
  }

  void setStateOutOfBuildPhrase(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        fn();
      });
    });
  }

  Widget detailCard(CurrentWeatherModel? currentWeather) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            width: 500,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Color(0xffcfe7e8).withOpacity(0.5),
                borderRadius: BorderRadius.circular(20.0)),
            child: Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: ClipOval(
                    child: _getLogoWeather(),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        currentWeather?.area.areaName?.first.value ??
                            "Ho Chi Minh City",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        '${currentWeather?.currentCondition.tempC} ~ (${currentWeather?.currentCondition.feelsLikeC})°',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      ClockRunner(),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        currentWeather
                                ?.currentCondition.weatherDesc?.first.value ??
                            "Sunny",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'H:${currentWeather?.currentCondition.humidity}°  L:56°',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _getLogoWeather() {
    return isDarkMode
        ? _logoWeather(
            "assets/images/icons/icon-evening.png"
          )
        : _logoWeather(
            "assets/images/icons/icon-sunny.png"
          );
  }

  Widget _logoWeather(String path) {
    return Image.asset(path,
      fit: BoxFit.cover,
      width: 180,
      height: 100,
    );
  }
}
