package com.thienday.headup.service.impl;

import com.thienday.headup.data.dto.CurrentWeatherDTO;
import com.thienday.headup.service.WeatherService;
import com.thienday.headup.service.weather.remote.client.WeatherClient;
import com.thienday.headup.service.weather.remote.client.WeatherClientImpl;
import com.thienday.headup.service.weather.remote.model.CurrentCondition;
import com.thienday.headup.service.weather.remote.model.WeatherResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WeatherServiceImpl implements WeatherService {

    @Autowired
    private WeatherClientImpl weatherClient;

    @Override
    public CurrentWeatherDTO getWeatherByCity(String city) {
        WeatherResponse resp = weatherClient.getCurrentWeatherByCity(city,"j1");
        if (resp == null) {
            return null;
        }
        CurrentWeatherDTO result = new CurrentWeatherDTO();
        result.setCurrentCondition(resp.getCurrent_condition().stream().findFirst().orElse(null));
        result.setArea(resp.getNearest_area().stream().findFirst().orElse(null));
        return result;
    }
}
