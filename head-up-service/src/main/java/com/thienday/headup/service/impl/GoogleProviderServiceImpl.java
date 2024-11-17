package com.thienday.headup.service.impl;

import com.nimbusds.jose.util.Base64;
import com.thienday.headup.configuration.security.SecurityConstants;
import com.thienday.headup.data.entities.UserEntity;
import com.thienday.headup.data.repositories.UserRepository;
import com.thienday.headup.jwt.JwtTokenProvider;
import com.thienday.headup.response.GoogleClaims;
import com.thienday.headup.service.AuthenticationProviderService;
import com.thienday.headup.service.AuthenticationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import static com.thienday.headup.constants.AppEnvironmentLoader.GOOGLE_CLIENT_ID;
import static com.thienday.headup.constants.AppEnvironmentLoader.GOOGLE_SOURCE;

@Service(value = "googleProviderService")
@Slf4j
public class GoogleProviderServiceImpl implements AuthenticationProviderService {

    @Autowired
    private AuthenticationService authenticationService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    @Autowired
    BCryptPasswordEncoder cryptPasswordEncoder;

    private static final String GOOGLE_VALIDATE_TOKEN_ENDPOINT = "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=";

    private static final String GOOGLE_USERINFO_ENDPOINT = "https://openidconnect.googleapis.com/v1/userinfo";

    @Override
    @Transactional
    public <T> T validateToken(String accessToken) {
        try {
            // validate provider
            GoogleClaims claims = getValidateInfoGoogleClaims(accessToken);

            if (!claims.getAudience().contains(GOOGLE_CLIENT_ID)) {
                throw new IllegalArgumentException("Token not accepted");
            }

            if (!(claims.getExpires_in() > 0)) {
                throw new IllegalArgumentException("Provider's token expired");
            }

            claims = getUserInfo(accessToken);
            assert claims != null;
            if (!userRepository.checkExistEmail(claims.getEmail())) {
                return (T) toRegister(claims);
            }
            return (T) claims.getEmail();
        } catch (RuntimeException e) {
            log.error("Error while validating token provider: {}", e.getMessage());
            throw e;
        }
    }

    @Override
    public <T> T toRegister(T claims) {
        GoogleClaims extractClaims = (GoogleClaims) claims;
        UserEntity user = new UserEntity();
        user.setUsername(extractClaims.getName());
        user.setEmail(extractClaims.getEmail());
        user.setPassword(cryptPasswordEncoder.encode(extractClaims.getUser_id()));
        user.setAvatar(extractClaims.getPicture());
        user.setMailActivated(extractClaims.getVerified_email());
        user.setRegisterSource(GOOGLE_SOURCE);
        user.setFirstName(extractClaims.getGiven_name());
        user.setLastName(extractClaims.getFamily_name());
        user.setGoogleId(extractClaims.getUser_id());
        user = userRepository.save(user);
        return (T) user.getEmail();
    }

    @Override
    public <T> T doLogin(T loginInfo) {
        try {
            UserEntity user = new UserEntity();
            GoogleClaims claimInfo = (GoogleClaims) loginInfo;
            user.setEmail(claimInfo.getEmail());
            user.setPassword(claimInfo.getUser_id());
            return (T) Base64.encode(jwtTokenProvider.generateToken(user.getEmail(), claimInfo.getUser_id())).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException("Error while generating the token : " + e.getMessage());
        }
    }

    private GoogleClaims getValidateInfoGoogleClaims(String accessToken) {
        try {
            RestTemplate rest = new RestTemplate();
            ResponseEntity<GoogleClaims> resp = rest.getForEntity(GOOGLE_VALIDATE_TOKEN_ENDPOINT.concat(accessToken), GoogleClaims.class);
            return resp.getBody();
        } catch (Exception e) {
            return null;
        }

    }

    private GoogleClaims getUserInfo(String accessToken) {
        try {
            RestTemplate rest = new RestTemplate();
            ResponseEntity<GoogleClaims> resp = rest.exchange(GOOGLE_USERINFO_ENDPOINT, HttpMethod.GET,
                    getHeaders(accessToken),GoogleClaims.class);
            return resp.getBody();
        } catch (Exception e) {
            return null;
        }

    }

    private HttpEntity<?> getHeaders(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.add(SecurityConstants.AUTHORIZATION, SecurityConstants.BEARER.concat(accessToken));
        return new HttpEntity(headers);
    }

}
