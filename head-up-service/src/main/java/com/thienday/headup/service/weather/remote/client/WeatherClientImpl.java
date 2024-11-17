package com.thienday.headup.service.weather.remote.client;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.thienday.headup.service.weather.WeatherConstants;
import com.thienday.headup.service.weather.remote.model.WeatherResponse;
import org.springframework.stereotype.Component;
import retrofit2.Call;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.jackson.JacksonConverterFactory;

@Component
public class WeatherClientImpl {

    private final WeatherClient weatherClient;

    public WeatherClientImpl() {
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        Retrofit retrofit = new Retrofit.Builder().baseUrl(WeatherConstants.WEATHER_BY_CITY)
                .addConverterFactory(JacksonConverterFactory.create(mapper))
                .build();
        this.weatherClient = retrofit.create(WeatherClient.class);
    }

    public WeatherResponse getCurrentWeatherByCity(String city, String format) {
        try {
            Call<WeatherResponse> execute = weatherClient.getCurrentWeatherByCity(city, format);
            Response<WeatherResponse> response = execute.execute();
            if (response.isSuccessful() && response.body() != null) {
                return response.body();
            }
        } catch (Exception e) {
        }
        return null;
    }
}
