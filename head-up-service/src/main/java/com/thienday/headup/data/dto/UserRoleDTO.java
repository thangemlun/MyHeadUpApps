package com.thienday.headup.data.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import net.minidev.json.annotate.JsonIgnore;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserRoleDTO extends BaseDTO{

    @JsonIgnore
    private UserDTO userDTO;

    private RoleDTO roleDTO;
}
