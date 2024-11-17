package com.thienday.headup.response;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
public class AuthorizedErrorResponse implements Serializable {
    private String timestamp;
    private int status;
    private String error;
    private String message;
    private String path;

    public AuthorizedErrorResponse(String timestamp, int status, String error, String message, String path) {
        this.timestamp = timestamp;
        this.status = status;
        this.error = error;
        this.message = message;
        this.path = path;
    }
}
