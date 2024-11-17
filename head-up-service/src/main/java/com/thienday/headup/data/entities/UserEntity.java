package com.thienday.headup.data.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.commons.lang3.ObjectUtils;

import java.util.Arrays;
import java.util.List;

@Table(name = "user", schema = "public")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class UserEntity extends BaseEntity{

    @Column(name = "username")
    private String username;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "display_name")
    private String displayName;

    @Column(name = "avatar")
    private String avatar;

    @Column(name = "mobile_phone")
    private String mobilePhone;

    @Column(name = "mail_activated")
    private Boolean mailActivated;

    @Column(name = "register_source")
    private String registerSource;

    @Column(name = "google_id")
    private String googleId;
    
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "user")
    List<UserRoleEntity> userRoles;

    @PrePersist
    @PreUpdate
    void setDisplayName() {
        if (ObjectUtils.anyNotNull(this.firstName, this.lastName)) {
            String firstName = this.firstName != null ? this.firstName : "";
            String lastName = this.lastName != null ? this.lastName : "";
            this.displayName = String.join(" ", Arrays.asList(firstName, lastName)).trim();
        }
    }
}
