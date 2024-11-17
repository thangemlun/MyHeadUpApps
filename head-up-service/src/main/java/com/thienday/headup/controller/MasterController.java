package com.thienday.headup.controller;

import com.thienday.headup.service.WeatherCityService;
import com.thienday.headup.service.excel.WeatherCityExcelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/master")
public class MasterController extends BaseController {
    @Autowired
    private WeatherCityExcelService weatherCityExcelService;

    @Autowired
    private WeatherCityService weatherCityService;

    @PostMapping("/city/import")
    public ResponseEntity<?> importCityData(MultipartFile file) {
        return execute(execute -> {
            weatherCityExcelService.importCityData(file);
            return null;
        },"Import successful");
    }

    @GetMapping("/city/all")
    public ResponseEntity<?> getAllCity() {
        return execute(execute -> {
            return weatherCityService.getAllCities();
        },"Retrieve all cities successful");
    }
}
