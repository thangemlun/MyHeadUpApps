part of 'current_weather_condition_bloc.dart';

@immutable
sealed class CurrentWeatherConditionEvent {}

class GetCurrentWeatherConditionEvent extends CurrentWeatherConditionEvent {
  final String city;
  GetCurrentWeatherConditionEvent(this.city);
}

class LoadCurrentWeatherConditionEvent extends CurrentWeatherConditionEvent {
  LoadCurrentWeatherConditionEvent();
}
