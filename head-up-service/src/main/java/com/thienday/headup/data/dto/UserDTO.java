package com.thienday.headup.data.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonValue;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO extends BaseDTO implements Serializable {
    private String username;
    private String email;
    private String displayName;
    private String firstName;
	private String lastName;
	private String mobilePhone;
    private String avatar;
}
