package com.thienday.headup.response;

import com.thienday.headup.enums.ResponseStatusEnum;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessageResponse implements Serializable {
    private String message;
	private Boolean success;

    public static MessageResponse apiError(String message) {
        return new MessageResponse(message, ResponseStatusEnum.FAILED.getStatus());
    }
}
