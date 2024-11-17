package com.thienday.headup.data.mapper;

import com.thienday.headup.data.dto.UserRoleDTO;
import com.thienday.headup.data.entities.UserRoleEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring")
public interface UserRoleMapper {
    UserRoleMapper INSTANCE = Mappers.getMapper(UserRoleMapper.class);

    @Mapping(target = "user", source = "userDTO")
    @Mapping(target = "role", source = "roleDTO")
	UserRoleEntity toEntity(UserRoleDTO userRoleDTO);

    @Mapping(target = "userDTO", source = "user")
    @Mapping(target = "roleDTO", source = "role")
    UserRoleDTO toDTO(UserRoleEntity userRoleEntity);
}
