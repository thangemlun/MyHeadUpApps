package com.thienday.headup.service.weather.remote.client;

import com.thienday.headup.service.weather.remote.model.WeatherResponse;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;
import retrofit2.http.Query;

public interface WeatherClient {
    @GET("/{city}")
    public Call<WeatherResponse> getCurrentWeatherByCity(
            @Path("city") String city,
            @Query("format") String format);
}
