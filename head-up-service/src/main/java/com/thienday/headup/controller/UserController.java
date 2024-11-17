package com.thienday.headup.controller;

import com.thienday.headup.data.dto.UpdateUserRequestDTO;
import com.thienday.headup.data.dto.UserDTO;
import com.thienday.headup.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserController extends BaseController{

    @Autowired
    private UserService userService;

    @GetMapping("/user-info")
    public ResponseEntity<?> getUserInfo() {
        return execute(data -> {
            return userService.getUserInfo();
        }, "Get User Successful");
    }

    @PutMapping("/update")
    public ResponseEntity<?> updateUser(@RequestBody UpdateUserRequestDTO request) {
        return execute(data -> {
            return userService.updateUser(request);
        },"Update User Successful");
    }
}
