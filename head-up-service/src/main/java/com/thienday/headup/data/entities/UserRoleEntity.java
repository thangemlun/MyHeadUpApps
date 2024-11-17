package com.thienday.headup.data.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Table(name = "user_role", schema = "public")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class UserRoleEntity extends BaseEntity {

    @ManyToOne
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    @MapsId("userId")
    private UserEntity user;

    @Column(name = "user_id")
    private Long userId;

    @ManyToOne(cascade = CascadeType.REMOVE)
    @JoinColumn(name = "role_id", insertable = false, updatable = false)
    @MapsId("roleId")
    private RoleEntity role;

    @Column(name = "role_id")
    private Long roleId;
}
