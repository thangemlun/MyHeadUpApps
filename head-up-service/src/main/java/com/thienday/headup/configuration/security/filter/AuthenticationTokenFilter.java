package com.thienday.headup.configuration.security.filter;

import com.thienday.headup.configuration.security.SecurityConstants;
import com.thienday.headup.configuration.security.provider.AuthenticationProvider;
import com.thienday.headup.configuration.security.provider.AuthenticationProviderSelector;
import com.thienday.headup.jwt.JwtTokenProvider;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

public class AuthenticationTokenFilter extends OncePerRequestFilter {

    @Autowired
    private AuthenticationProviderSelector selector;

    @Autowired
    private UserDetailsService userDetailsService;
    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        try {
//            if (AppEnvironmentLoader.checkPublic(request.getRequestURI())) {
//                filterChain.doFilter(request, response);
//                return;
//            }
            String grantedMode = request.getHeader(SecurityConstants.AUTHORIZATION_GRANTED_MODE);
            String externalSystem = request.getHeader(SecurityConstants.AUTHORIZATION_EXTERNAL_SYSTEM);
            AuthenticationProvider provider = selector.selectByGrantedMode(grantedMode, externalSystem);
            Authentication authentication = provider.authenticate(request);
			if (authentication != null) {
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        } catch (Exception e) {}
        filterChain.doFilter(request, response);
    }
}
