package com.thienday.headup.service.weather.remote.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class CurrentCondition {
    @JsonProperty(value = "FeelsLikeC")
    private String feelsLikeC;
    @JsonProperty(value = "FeelsLikeF")
    private String feelsLikeF;
    private String cloudCover;
    private String humidity;
    private String localObsDateTime;
    private String observation_time;
    private String precipInches;
    private String precipMM;
    private String pressure;
    private String pressureInches;
    private String temp_C;
    private String temp_F;
    private String uvIndex;
    private String visibility;
    private String visibilityMiles;
    private String weatherCode;
    private List<WeatherDesc> weatherDesc;
    private List<WeatherIconUrl> weatherIconUrl;
    private String winddir16Point;
    private String winddirDegree;
    private String windspeedKmph;
    private String windspeedMiles;
}
