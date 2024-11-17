package com.thienday.headup.configuration.security;

import com.thienday.headup.configuration.security.services.UserDetailsImpl;
import jakarta.annotation.PostConstruct;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.annotation.RequestScope;

@RequestScope
@Component
@Getter
@Slf4j
public class UserSession {

    private UserDetailsImpl userDetails;

    @PostConstruct
    void loadUserDetail() {
        this.userDetails = null;
        this.setUserDetails();
    }

    void setUserDetails() {
        try {
        	this.userDetails = (UserDetailsImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        } catch (Exception e) {
            log.error("Failed to get session user on request thread: {}", e.getMessage());
        }
    }

}
