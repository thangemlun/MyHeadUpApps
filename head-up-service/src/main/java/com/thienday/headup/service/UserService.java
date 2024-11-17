package com.thienday.headup.service;

import com.thienday.headup.data.dto.UpdateUserRequestDTO;
import com.thienday.headup.data.dto.UserDTO;

public interface UserService {
    public UserDTO getUserInfo();

    UserDTO updateUser(UpdateUserRequestDTO request);
}
