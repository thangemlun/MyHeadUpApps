package com.thienday.headup.data.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Table(name = "weather_city", schema = "public")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class WeatherCityEntity extends BaseEntity{

    @Column(name = "city")
    private String city;

    @Column(name = "lat")
    private float lat;

    @Column(name = "lon")
    private float lon;

    @Column(name = "country")
    private String country;

    @Column(name = "country_code")
    private String countryCode;
}
