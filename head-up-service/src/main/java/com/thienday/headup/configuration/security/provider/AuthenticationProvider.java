package com.thienday.headup.configuration.security.provider;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.Authentication;

public interface AuthenticationProvider {
    public Authentication authenticate(HttpServletRequest request);
}
