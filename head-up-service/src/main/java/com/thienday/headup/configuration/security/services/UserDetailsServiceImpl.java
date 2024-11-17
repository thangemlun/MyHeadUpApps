package com.thienday.headup.configuration.security.services;

import com.thienday.headup.data.entities.UserEntity;
import com.thienday.headup.data.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

	@Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        UserEntity user = Optional.ofNullable(userRepository.findUserByEmail(email))
                .orElseThrow();
        return UserDetailsImpl.build(user);
    }
}
