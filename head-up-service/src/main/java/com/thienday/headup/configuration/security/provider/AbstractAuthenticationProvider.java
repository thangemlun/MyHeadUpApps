package com.thienday.headup.configuration.security.provider;

import com.thienday.headup.configuration.security.SecurityConstants;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;

import java.util.Objects;

public abstract class AbstractAuthenticationProvider implements AuthenticationProvider{
    @Override
    public Authentication authenticate(HttpServletRequest request) {
        String tokenHeader = request.getHeader("Authorization");
        if(Objects.nonNull(tokenHeader) && (tokenHeader.startsWith(SecurityConstants.BEARER))) {
            StringBuilder tokenSb = new StringBuilder(tokenHeader);
            String token = tokenSb.substring(SecurityConstants.BEARER.length());
            String sub = validateToken(token, request);

            if(Objects.isNull(sub)) {
                return null;
            }

            UserDetails userDetails = buildUserDetails(sub, request);

            if (Objects.isNull(userDetails)) {
                return null;
            }

            UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails,
                    null, userDetails.getAuthorities());
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

            return authentication;
        }
        return null;
    }

    public abstract String validateToken(String token, HttpServletRequest request);

    public abstract UserDetails buildUserDetails(String email, HttpServletRequest request);
}
