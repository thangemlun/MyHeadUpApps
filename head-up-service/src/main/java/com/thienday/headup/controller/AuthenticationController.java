package com.thienday.headup.controller;

import com.thienday.headup.constants.AppEnvironmentLoader;
import com.thienday.headup.request.LoginRequest;
import com.thienday.headup.request.ProviderLoginRequest;
import com.thienday.headup.request.UserRegisterRequest;
import com.thienday.headup.service.AuthenticationProviderService;
import com.thienday.headup.service.AuthenticationService;
import com.thienday.headup.utillize.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthenticationController extends BaseController{
    Map<String, AuthenticationProviderService> providerMap;

    @Autowired
    private AuthenticationProviderService googleProviderService;

    AuthenticationController() {
        providerMap = new HashMap<>();
        providerMap.put(AppEnvironmentLoader.GOOGLE_PROVIDER, this.googleProviderService);
    }

    @Autowired
    private AuthenticationService authenticationService;

    @Autowired
    private EmailService emailService;

	@PostMapping("/register")
    public ResponseEntity register(@RequestBody UserRegisterRequest request) {
        return execute(execute -> authenticationService.registerUser(request), "Register successful");
    }

    @GetMapping("/test-email")
    public void test() {
        emailService.sendRegisterEmail("thien2357@gmail.com");
    }

    @GetMapping("/verify-register")
    public ResponseEntity register(@RequestParam String mail) {
        return execute(execute -> authenticationService.verifyMail(mail), "Verify successful");
    }

//	@PostMapping("/app-auth")
//    public ResponseEntity providerAuthenticate(@RequestHeader(name = "Access-Token") String accessToken,
//                                               @RequestParam String pc, @RequestBody ProviderLoginRequest providerRequest) {
//		return execute(execute -> {
//            if (pc.equals(AppEnvironmentLoader.GOOGLE_PROVIDER)) {
//                return googleProviderService.validateToken(accessToken);
//            }
//            return null;
//        }, "Login Successful");
//    }

    @PostMapping
    public ResponseEntity login(@RequestBody LoginRequest request) {
        return execute(execute -> {
            return authenticationService.login(request);
        }, "Login Successful");
    }

//    @PostMapping("/validate")
//    public ResponseEntity validateToken(@RequestHeader(name = "Access-Token") String token) {
//        return execute(execute -> {
//            return authenticationService.validateToken(token);
//        },"Token valid");
//    }
}
