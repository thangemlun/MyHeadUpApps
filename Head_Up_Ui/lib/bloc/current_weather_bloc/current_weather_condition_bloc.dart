import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:head_up_ui/model/current_weather_model.dart';
import 'package:head_up_ui/services/impl/weather_service_impl.dart';
import 'package:head_up_ui/services/weather_service.dart';
import 'package:meta/meta.dart';

part 'current_weather_condition_event.dart';
part 'current_weather_condition_state.dart';

class CurrentWeatherConditionBloc extends Bloc<CurrentWeatherConditionEvent, CurrentWeatherConditionState> {

  final WeatherService weatherService = WeatherServiceImpl();
  final eventController = StreamController<CurrentWeatherConditionEvent>();
  final stateController = StreamController<CurrentWeatherConditionState>();

  CurrentWeatherConditionBloc() : super(CurrentWeatherConditionInitial()) {
    eventController.stream.listen((event) async {
      if (event is GetCurrentWeatherConditionEvent) {
        try {
          CurrentWeatherModel currentCondition = await weatherService.getCurrentWeatherByCity(event.city);
          stateController.sink.add(LoadCurrentWeatherConditionState(currentCondition));
        } catch (e) {
          stateController.sink.add(CurrentWeatherConditionInitial());
        }

      }
      if (event is LoadCurrentWeatherConditionEvent) {
        stateController.sink.add(CurrentWeatherConditionInitial());
      }
    });
  }

}
