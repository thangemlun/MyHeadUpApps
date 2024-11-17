package com.thienday.headup.service.weather.remote.model;
import lombok.Data;

import java.util.List;

@Data
public class NearestArea {
    private List<AreaName> areaName;
    private List<Country> country;
    private String latitude;
    private String longitude;
    private String population;
    private List<Region> region;
    private List<WeatherUrl> weatherUrl;
}

@Data
class AreaName {
    private String value;
}

@Data
class Country {
    private String value;
}

@Data
class Region {
    private String value;
}

@Data
class WeatherUrl {
    private String value;
}
