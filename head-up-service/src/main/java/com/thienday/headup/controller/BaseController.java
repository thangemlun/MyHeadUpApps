package com.thienday.headup.controller;

import com.thienday.headup.response.DataResponse;
import com.thienday.headup.response.MessageResponse;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.function.Function;

public class BaseController {

    public <R> ResponseEntity<?> execute(Function<R,?> service, String message){
        try{
            return ResponseEntity.ok(DataResponse.apiResult(service.apply(null)
                    ,message));
        }catch (RuntimeException e){
        	throw e ;
        }
    }

    public <T> ResponseEntity<T> makeReponse(T data, String message) {
        return new ResponseEntity(DataResponse.apiResult(data, message), HttpStatus.OK);
    }

    public ResponseEntity executeByteStream(ByteArrayInputStream data, String fileName, String message) {
        return ResponseEntity.status(HttpStatus.OK)
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + fileName + ".xlsx")
                .contentType(MediaType.parseMediaType("application/vnd.ms-excel"))
                .body(new InputStreamResource(data));
    }
}
