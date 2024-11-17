package com.thienday.headup.service;

import com.thienday.headup.data.dto.CurrentWeatherDTO;
import com.thienday.headup.service.weather.remote.model.WeatherResponse;

public interface WeatherService {
	CurrentWeatherDTO getWeatherByCity(String city);
}
