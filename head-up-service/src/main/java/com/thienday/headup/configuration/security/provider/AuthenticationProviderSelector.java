package com.thienday.headup.configuration.security.provider;

import com.thienday.headup.configuration.security.SecurityConstants;
import lombok.Setter;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.util.Objects;

@Setter
public class AuthenticationProviderSelector {
    public AuthenticationProviderSelector() {}

    private JwtAuthenticationProvider jwtAuthenticationProvider = null;

    private GoogleAuthenticationProvider googleAuthenticationProvider = null;

    public AuthenticationProvider selectByGrantedMode(String grantedMode, String externalSystem) {
        if (grantedMode == null || grantedMode.equals(SecurityConstants.JWT_AUTH)) {
            return jwtAuthenticationProvider;
        }

        if (grantedMode.equals(SecurityConstants.EXTERNAL_SERVICE) && Objects.nonNull(externalSystem)) {
            if (externalSystem.equals(SecurityConstants.GOOGLE)) {
                return googleAuthenticationProvider;
            }
        }

        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Can not find authentication provider with granted mode is : " + grantedMode);
    }

}
