part of 'current_weather_condition_bloc.dart';

@immutable
sealed class CurrentWeatherConditionState {}

final class CurrentWeatherConditionInitial extends CurrentWeatherConditionState {
  CurrentWeatherConditionInitial();
}

final class LoadCurrentWeatherConditionState extends CurrentWeatherConditionState {
  final CurrentWeatherModel currentCondition;
  LoadCurrentWeatherConditionState(this.currentCondition);
}