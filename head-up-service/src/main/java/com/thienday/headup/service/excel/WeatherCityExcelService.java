package com.thienday.headup.service.excel;

import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;

public interface WeatherCityExcelService {
    void importCityData(MultipartFile file);
}
