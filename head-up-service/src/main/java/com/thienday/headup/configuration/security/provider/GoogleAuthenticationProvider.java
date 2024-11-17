package com.thienday.headup.configuration.security.provider;

import com.thienday.headup.service.AuthenticationProviderService;
import com.thienday.headup.service.AuthenticationService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

public class GoogleAuthenticationProvider extends AbstractAuthenticationProvider{

    private AuthenticationProviderService googleProviderService;

    private UserDetailsService userDetailsService;

    public GoogleAuthenticationProvider() {}

    public GoogleAuthenticationProvider(UserDetailsService userDetailsService, AuthenticationProviderService googleProviderService) {
        this.userDetailsService = userDetailsService;
        this.googleProviderService = googleProviderService;
    }


    @Override
    public String validateToken(String token, HttpServletRequest request) {
        return googleProviderService.validateToken(token);
    }

    @Override
    public UserDetails buildUserDetails(String email, HttpServletRequest request) {
        return userDetailsService.loadUserByUsername(email);
    }
}
