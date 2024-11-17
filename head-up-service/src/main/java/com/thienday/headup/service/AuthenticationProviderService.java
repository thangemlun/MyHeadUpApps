package com.thienday.headup.service;

import com.thienday.headup.request.ProviderLoginRequest;

public interface AuthenticationProviderService {
    public <T> T validateToken(String accessToken);
    public <T> T toRegister(T claims);
    public <T> T doLogin(T loginInfo);
}
