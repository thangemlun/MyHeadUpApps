package com.thienday.headup.data.dto;

import jakarta.persistence.Column;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

@EqualsAndHashCode(callSuper = true)
@Data
public class WeatherCityDTO extends BaseDTO implements Serializable {
    private String city;
    private float lat;
    private float lon;
    private String country;
    private String countryCode;
}
