package com.thienday.headup.service.impl;

import com.thienday.headup.configuration.security.UserSession;
import com.thienday.headup.configuration.security.services.UserDetailsImpl;
import com.thienday.headup.data.dto.UpdateUserRequestDTO;
import com.thienday.headup.data.dto.UserDTO;
import com.thienday.headup.data.entities.UserEntity;
import com.thienday.headup.data.mapper.UserMapper;
import com.thienday.headup.data.repositories.UserRepository;
import com.thienday.headup.exception.ItemNotFoundException;
import com.thienday.headup.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserSession userSession;

    @Override
    public UserDTO getUserInfo() {
        return userMapper.toDTO(userRepository.findUserByEmail(userSession.getUserDetails().getEmail()));
    }

    @Override
    public UserDTO updateUser(UpdateUserRequestDTO request) {
        try {
            Optional<UserEntity> userOptional = userRepository.findById(request.getId());
            if (!userOptional.isPresent()) {
                throw new ItemNotFoundException("User Id not found !");
            }
            UserEntity user = userOptional.get();
            userMapper.updateFromUpdateRequestDTO(request, user);
            return userMapper.toDTO(userRepository.save(user));
        } catch (RuntimeException e) {
            throw new RuntimeException("Error while updating user : " + e.getMessage());
        }
    }
}
