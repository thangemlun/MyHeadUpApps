package com.thienday.headup.data.mapper;

import com.thienday.headup.data.dto.RoleDTO;
import com.thienday.headup.data.entities.RoleEntity;
import org.mapstruct.Mapper;
import org.mapstruct.NullValueCheckStrategy;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring" , nullValueCheckStrategy = NullValueCheckStrategy.ALWAYS, uses = {
        UserRoleMapper.class})
public interface RoleMapper {
    RoleMapper INSTANCE = Mappers.getMapper(RoleMapper.class);

    RoleEntity toEntity(RoleDTO roleDTO);

    RoleDTO toDTO(RoleEntity roleEntity);
}
