package com.thienday.headup.configuration.security.provider;

import com.thienday.headup.jwt.JwtTokenProvider;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

public class JwtAuthenticationProvider extends AbstractAuthenticationProvider{

    private UserDetailsService userDetailsService;

    private JwtTokenProvider jwtTokenProvider;

    public JwtAuthenticationProvider(UserDetailsService userDetailsService, JwtTokenProvider jwtTokenProvider) {
        this.userDetailsService = userDetailsService;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Override
    public String validateToken(String token, HttpServletRequest request) {
        try {
            if (jwtTokenProvider.validateToken(token)) {
                return jwtTokenProvider.getEmailFromToken(token);
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public UserDetails buildUserDetails(String email, HttpServletRequest request) {
        return userDetailsService.loadUserByUsername(email);
    }
}
