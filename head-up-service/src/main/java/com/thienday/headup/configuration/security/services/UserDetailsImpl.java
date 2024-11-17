package com.thienday.headup.configuration.security.services;

import com.thienday.headup.data.entities.UserEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@AllArgsConstructor
public class UserDetailsImpl implements UserDetails {
    private String username;
    private String password;
    private String email;

    private List<String> roles;

    private final Collection<? extends GrantedAuthority> authorities;

    public UserDetailsImpl(String username, String email, String password, Collection<? extends GrantedAuthority> authorities) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.authorities = authorities;
    }

    public static UserDetailsImpl build (UserEntity user) {
        return new UserDetailsImpl(user.getUsername(), user.getEmail(), user.getPassword(),
                user.getUserRoles()
                        .stream()
                        .map(ur -> new SimpleGrantedAuthority(ur.getRole().getRoleCode()))
                        .collect(Collectors.toList()));
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    @Override
    public String getUsername() {
        return this.username;
    }
}
