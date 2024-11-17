package com.thienday.headup.controller;

import com.thienday.headup.service.WeatherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/weather")
public class WeatherController extends BaseController {

    @Autowired
    private WeatherService weatherService;

    @GetMapping("/{city}")
    public ResponseEntity<?> getWeatherByCity(@PathVariable("city") String city) {
        return execute(execute -> {
           return weatherService.getWeatherByCity(city);
        }, "Get Weather Data Successfully");
    }
}
