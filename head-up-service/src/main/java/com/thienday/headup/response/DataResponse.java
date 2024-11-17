package com.thienday.headup.response;

import com.thienday.headup.enums.ResponseStatusEnum;
import lombok.*;

import java.io.Serializable;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class DataResponse implements Serializable {
    private Object data;
    private String message;
    private Boolean success;

    public static DataResponse init(){
        return new DataResponse();
    }

    public DataResponse data(Object data) {
        this.setData(data);
        return this;
    }

    public DataResponse message(String message) {
        this.setMessage(message);
        return this;
    }

    public DataResponse success(Boolean success) {
        this.setSuccess(success);
        return this;
    }
    public static <T> DataResponse apiResult(T data, String message){
        return DataResponse
                .init()
                .data(data)
                .message(message)
                .success(ResponseStatusEnum.SUCCESS.getStatus());
    }
}
