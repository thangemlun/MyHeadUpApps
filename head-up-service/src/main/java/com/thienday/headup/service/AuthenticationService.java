package com.thienday.headup.service;

import com.thienday.headup.data.dto.UserDTO;
import com.thienday.headup.request.LoginRequest;
import com.thienday.headup.request.UserRegisterRequest;

public interface AuthenticationService {
	UserDTO registerUser(UserRegisterRequest request);

	Boolean verifyMail(String email);

	String login(LoginRequest request);

	boolean validateToken(String token);
}
