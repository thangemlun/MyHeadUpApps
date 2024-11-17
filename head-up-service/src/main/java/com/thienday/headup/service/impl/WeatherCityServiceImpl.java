package com.thienday.headup.service.impl;

import com.thienday.headup.data.dto.WeatherCityDTO;
import com.thienday.headup.data.entities.WeatherCityEntity;
import com.thienday.headup.data.mapper.WeatherCityMapper;
import com.thienday.headup.data.repositories.WeatherCityRepository;
import com.thienday.headup.service.WeatherCityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class WeatherCityServiceImpl implements WeatherCityService {

    @Autowired
    private WeatherCityRepository weatherCityRepository;

    @Autowired
    private WeatherCityMapper weatherCityMapper;

    @Override
    public List<WeatherCityDTO> getAllCities() {
        List<WeatherCityEntity> allCities = weatherCityRepository.findAll();
        return allCities.stream().map(entity -> weatherCityMapper.toDTO(entity)).toList();
    }
}
