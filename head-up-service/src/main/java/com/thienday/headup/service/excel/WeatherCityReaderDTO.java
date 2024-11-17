package com.thienday.headup.service.excel;

import com.thienday.headup.data.entities.WeatherCityEntity;
import lombok.Data;

@Data
public class WeatherCityReaderDTO {
    private String city;
    private float lat;
    private float lng;
    private String country;
    private String iso2;
    private boolean isAdd;

    public static WeatherCityEntity toEntity(WeatherCityReaderDTO reader) {
        return new WeatherCityEntity(reader.getCity(), reader.getLat(), reader.getLng(), reader.getCountry(),
                reader.getIso2());
    }
}
