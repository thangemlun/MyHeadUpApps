package com.thienday.headup.data.repositories;

import com.thienday.headup.data.entities.WeatherCityEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface WeatherCityRepository extends JpaRepository<WeatherCityEntity, Long> {

}
