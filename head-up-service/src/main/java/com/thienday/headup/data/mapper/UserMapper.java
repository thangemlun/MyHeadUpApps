package com.thienday.headup.data.mapper;

import com.thienday.headup.data.dto.UpdateUserRequestDTO;
import com.thienday.headup.data.dto.UserDTO;
import com.thienday.headup.data.entities.UserEntity;
import org.mapstruct.InheritInverseConfiguration;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValueCheckStrategy;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring", nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS, uses = {
        UserRoleMapper.class})
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    UserEntity toEntity(UserDTO userDTO);
    UserDTO toDTO(UserEntity entity);

    void updateFromUpdateRequestDTO(UpdateUserRequestDTO userRequestDTO, @MappingTarget UserEntity entity);
}
