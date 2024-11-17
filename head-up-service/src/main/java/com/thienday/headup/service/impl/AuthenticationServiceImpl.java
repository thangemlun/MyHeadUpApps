package com.thienday.headup.service.impl;

import com.nimbusds.jose.util.Base64;
import com.thienday.headup.data.dto.UserDTO;
import com.thienday.headup.data.entities.UserEntity;
import com.thienday.headup.data.mapper.UserMapper;
import com.thienday.headup.data.repositories.UserRepository;
import com.thienday.headup.exception.ItemExistedException;
import com.thienday.headup.exception.ItemNotFoundException;
import com.thienday.headup.jwt.JwtTokenProvider;
import com.thienday.headup.request.LoginRequest;
import com.thienday.headup.request.UserRegisterRequest;
import com.thienday.headup.service.AuthenticationService;
import com.thienday.headup.utillize.EmailService;
import lombok.SneakyThrows;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.NotActiveException;
import java.util.MissingResourceException;
import java.util.Optional;
import java.util.concurrent.ExecutorService;

@Service
public class AuthenticationServiceImpl implements AuthenticationService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private EmailService emailService;

    @Autowired
    private ExecutorService virtualExecutor;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;


    @Override
    public UserDTO registerUser(UserRegisterRequest request) {
        if (ObjectUtils.allNotNull(request.getEmail(), request.getPassword(), request.getUsername())) {
            if (userRepository.checkExistEmail(request.getEmail())) {
                throw new ItemExistedException("Email existed");
            }

            if (userRepository.checkExistActivatedUsername(request.getUsername())) {
                throw new ItemExistedException("Username existed");
            }

            UserEntity saveUser = new UserEntity();
            saveUser.setUsername(request.getUsername());
            saveUser.setEmail(request.getEmail());
            saveUser.setPassword(bCryptPasswordEncoder.encode(request.getPassword()));
            saveUser.setMailActivated(false);

            // async
            virtualExecutor.submit(() -> emailService.sendRegisterEmail(saveUser.getEmail()));

            userRepository.save(saveUser);
            return userMapper.toDTO(saveUser);
        } else {
            request.getClass().getDeclaredFields();
            throw new MissingResourceException("Missing required value", UserRegisterRequest.class.getName(),
                    request.getClass().getFields().toString());
        }
    }

    @Override
    public Boolean verifyMail(String email) {
        if (userRepository.checkEmailNeedToActivate(email)) {
            userRepository.activateMail(email);
            return true;
        } else {
            throw new ItemExistedException("Mail is already verified");
        }
    }

    @SneakyThrows
    @Override
    public String login(LoginRequest request) {
        Optional<UserEntity> optionalUser = Optional.ofNullable(userRepository.findUserByEmail(request.getEmail()));
        if (optionalUser.isEmpty()) {
            throw new ItemNotFoundException("Email not registered");
        }
        // get user from optional box
        UserEntity user = optionalUser.get();
        if (!user.getMailActivated()) {
            throw new IllegalAccessException("Email not verified");
        }
        if (!bCryptPasswordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new IllegalAccessException("Password not correct");
        }
        return Base64.encode(jwtTokenProvider.generateToken(user.getEmail(), request.getPassword())).toString();
    }

    @SneakyThrows
    @Override
    public boolean validateToken(String token) {
        try {
            if (!jwtTokenProvider.validateToken(token)) {
                throw new NotActiveException("Token invalid");
            }
            String email = jwtTokenProvider.getEmailFromToken(token);
            String pw = jwtTokenProvider.getPasswordFromToken(token);
            return bCryptPasswordEncoder.matches(pw, userRepository.findUserByEmail(email).getPassword());
        } catch (Exception e) {
            throw new NotActiveException("Token invalid");
        }
    }
}
