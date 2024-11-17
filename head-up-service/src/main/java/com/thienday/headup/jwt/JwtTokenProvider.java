package com.thienday.headup.jwt;

import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.RSASSASigner;
import com.nimbusds.jose.crypto.RSASSAVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.interfaces.RSAPublicKey;
import java.util.Date;

@Component
@Slf4j
public class JwtTokenProvider {
    private KeyPair keyPair;
    private final String JWT_SECRET = System.getenv("jwt_alarm_project_secret");
    private final long JWT_EXPIRATION = 2*3600*1000;

    @PostConstruct
    public void init() throws NoSuchAlgorithmException {
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
            keyPairGenerator.initialize(2048);
            keyPair = keyPairGenerator.generateKeyPair();
        } catch (Exception e){}

    }

    public String generateToken(String email, String pw) {
        try {
            JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
                    .claim("email", email)
                    .claim("pw", pw)
                    .issuer(JWT_SECRET)
                    .expirationTime(new Date(new Date().getTime() + JWT_EXPIRATION)) // Token hết hạn sau 1 phút
                    .build();

            JWSHeader header = new JWSHeader.Builder(JWSAlgorithm.RS256).type(JOSEObjectType.JWT).build();
            SignedJWT signedJWT = new SignedJWT(header, claimsSet);
            JWSSigner signer = new RSASSASigner(keyPair.getPrivate());
            signedJWT.sign(signer);

            return signedJWT.serialize();
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException("Error while generating token");
        }
    }

    public String getEmailFromToken(String token) {
        try {
            if (!validateToken(token)) {
                throw new IllegalArgumentException("Token not valid");
            }
            SignedJWT signedJWT = SignedJWT.parse(token);
            return signedJWT.getJWTClaimsSet().getStringClaim("email");
        } catch (Exception e) {
            throw new IllegalArgumentException("Error while parsing token");
        }

    }

    public String getPasswordFromToken(String token) {
        try {
            if (!validateToken(token)) {
                throw new IllegalArgumentException("Token not valid");
            }
            SignedJWT signedJWT = SignedJWT.parse(token);
            return signedJWT.getJWTClaimsSet().getStringClaim("pw");
        } catch (Exception e) {
            throw new IllegalArgumentException("Error while parsing token");
        }
    }


    public boolean validateToken(String token) throws Exception {
        SignedJWT signedJWT = SignedJWT.parse(token);
        JWSVerifier verifier = new RSASSAVerifier((RSAPublicKey) keyPair.getPublic());
        return signedJWT.verify(verifier);
    }

    public PublicKey getPublicKey() {
        return keyPair.getPublic();
    }
}
