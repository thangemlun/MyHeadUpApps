package com.thienday.headup.configuration.security.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thienday.headup.response.AuthorizedErrorResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.Instant;

@Component
public class MyAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
		String errMes = authException.getMessage();
        ObjectMapper mapper = new ObjectMapper();
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("UTF-8");
		response.getWriter().write(mapper.writeValueAsString(new AuthorizedErrorResponse(Instant.now().toString(),
                HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized", errMes, request.getRequestURI()))
        );
    }


}
