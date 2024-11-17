package com.thienday.headup.data.dto;

import com.thienday.headup.service.weather.remote.model.CurrentCondition;
import com.thienday.headup.service.weather.remote.model.NearestArea;
import lombok.Data;

@Data
public class CurrentWeatherDTO {
	private CurrentCondition currentCondition;
    private NearestArea area;
}
