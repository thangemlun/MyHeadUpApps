package com.thienday.headup.response;

import lombok.Data;

import java.io.Serializable;

@Data
public class GoogleClaims implements Serializable {
    private String issued_to;
    private String audience;
    private String user_id;
    private String scope;
    private Long expires_in;
    private String email;
    private Boolean verified_email;
    private String access_type;
    private String picture;
    private String name;
    private String sub;
    private String family_name;
    private String given_name;
}
