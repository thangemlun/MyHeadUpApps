package com.thienday.headup.data.mapper;

import com.thienday.headup.data.dto.WeatherCityDTO;
import com.thienday.headup.data.entities.WeatherCityEntity;
import org.mapstruct.Mapper;
import org.mapstruct.NullValueCheckStrategy;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring", nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS)
public interface WeatherCityMapper {
    WeatherCityMapper INSTANCE = Mappers.getMapper(WeatherCityMapper.class);

    WeatherCityEntity toEntity(WeatherCityDTO weatherCityDTO);

    WeatherCityDTO toDTO(WeatherCityEntity weatherCityEntity);
}
