package com.thienday.headup.service.excel.impl;

import com.thienday.headup.data.entities.WeatherCityEntity;
import com.thienday.headup.data.repositories.WeatherCityRepository;
import com.thienday.headup.service.excel.WeatherCityExcelService;
import com.thienday.headup.service.excel.WeatherCityReaderDTO;
import io.github.nambach.excelutil.core.Editor;
import io.github.nambach.excelutil.core.ReaderConfig;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Service
public class WeatherCityExcelServiceImpl implements WeatherCityExcelService {

    @Autowired
    private WeatherCityRepository weatherCityRepository;

    @Override
    public void importCityData(MultipartFile file) {
        try {
            Editor editor = new Editor(file.getInputStream());
            editor.goToSheet("weather_city").goToCell(0,0);
            List<WeatherCityReaderDTO> importedCities = new ArrayList<>();
            importedCities = editor.readSection(getCityReaderConfig());
            if (CollectionUtils.isNotEmpty(importedCities)) {
                List<WeatherCityEntity> entities = importedCities.stream().filter(data -> data.isAdd())
                        .map(WeatherCityReaderDTO::toEntity).toList();
                if (CollectionUtils.isNotEmpty(entities)) {
                    weatherCityRepository.saveAll(entities);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Error while importing city data: " + e.getMessage());
        }
    }

    private ReaderConfig getCityReaderConfig() {
        return ReaderConfig.fromClass(WeatherCityReaderDTO.class)
                .titleAtRow(0)
                .dataFromRow(1)
                .handler(set -> set.atColumn("city").handle((weatherCity, cell) -> {
                    String value = cell.readString().trim();
                    weatherCity.setCity(value);
                }))
                .handler(set -> set.atColumn("lat").handle((weatherCity, readerCell) -> {
                  float value = readerCell.readFloat();
                  weatherCity.setLat(value);
                }))
                .handler(set -> set.atColumn("lng").handle((weatherCity, readerCell) -> {
                    float value = readerCell.readFloat();
                    weatherCity.setLng(value);
                }))
                .handler(set -> set.atColumn("lat").handle((weatherCity, readerCell) -> {
                    float value = readerCell.readFloat();
                    weatherCity.setLat(value);
                }))
                .handler(set -> set.atColumn("country").handle((weatherCity, readerCell) -> {
                    String value = readerCell.readString();
                    weatherCity.setCountry(value);
                }))
                .handler(set -> set.atColumn("iso2").handle((weatherCity, readerCell) -> {
                    String value = readerCell.readString();
                    weatherCity.setIso2(value);
                }))
                .handler(set -> set.atColumn("is_add").handle((weatherCity, readerCell) -> {
                    boolean value = readerCell.readBoolean();
                    weatherCity.setAdd(value);
                }));
    }
}
