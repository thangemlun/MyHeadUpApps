package com.thienday.headup.service;

import com.thienday.headup.data.dto.WeatherCityDTO;

import java.util.List;

public interface WeatherCityService {
    List<WeatherCityDTO> getAllCities();
}
