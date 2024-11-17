package com.thienday.headup.configuration.security;

import com.thienday.headup.configuration.security.filter.AuthenticationTokenFilter;
import com.thienday.headup.configuration.security.filter.MyAuthenticationEntryPoint;
import com.thienday.headup.configuration.security.provider.AuthenticationProviderSelector;
import com.thienday.headup.configuration.security.provider.GoogleAuthenticationProvider;
import com.thienday.headup.configuration.security.provider.JwtAuthenticationProvider;
import com.thienday.headup.jwt.JwtTokenProvider;
import com.thienday.headup.service.AuthenticationProviderService;
import com.thienday.headup.service.impl.GoogleProviderServiceImpl;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(
        prePostEnabled = true
)
public class WebSecurityConfig {

    @Bean
    public AuthenticationTokenFilter authenticationTokenFilter() {
        return new AuthenticationTokenFilter();
    }

    @Bean
    public MyAuthenticationEntryPoint myAuthenticationEntryPoint() {return new MyAuthenticationEntryPoint();}

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    @ConditionalOnBean(value = {UserDetailsService.class, AuthenticationProviderService.class, JwtTokenProvider.class})
    public AuthenticationProviderSelector authenticationProviderSelector (UserDetailsService userDetailsService,
                                                                          AuthenticationProviderService googleProviderService,
                                                                          JwtTokenProvider jwtTokenProvider) {
        AuthenticationProviderSelector selector = new AuthenticationProviderSelector();
        selector.setJwtAuthenticationProvider(new JwtAuthenticationProvider(userDetailsService, jwtTokenProvider));
        selector.setGoogleAuthenticationProvider(new GoogleAuthenticationProvider(userDetailsService, googleProviderService));
        return selector;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .exceptionHandling().authenticationEntryPoint(myAuthenticationEntryPoint()).and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
                .authorizeRequests()
                .requestMatchers("/api/auth/**").permitAll()
                .anyRequest().authenticated().and()
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .addFilterBefore(authenticationTokenFilter(), UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration corsConfiguration = new CorsConfiguration().applyPermitDefaultValues();
        corsConfiguration.setAllowedMethods(Arrays.asList("GET", "PUT", "POST", "PATCH", "DELETE", "OPTIONS"));
        source.registerCorsConfiguration("/**", corsConfiguration);
        return source;
    }
}
