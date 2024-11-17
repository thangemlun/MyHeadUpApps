package com.thienday.headup.service.weather.remote.model;

import lombok.Data;

import java.util.List;

@Data
public class WeatherResponse {
    private List<CurrentCondition> current_condition;
    private List<NearestArea> nearest_area;
}
