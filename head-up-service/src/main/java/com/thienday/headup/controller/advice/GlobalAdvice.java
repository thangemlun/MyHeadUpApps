package com.thienday.headup.controller.advice;

import com.thienday.headup.exception.ItemExistedException;
import com.thienday.headup.exception.ItemNotFoundException;
import com.thienday.headup.response.MessageResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.io.NotActiveException;

@ControllerAdvice
public class GlobalAdvice extends ResponseEntityExceptionHandler {
    @ExceptionHandler(value = {ItemNotFoundException.class})
    protected ResponseEntity handleNotFound(ItemNotFoundException ex, WebRequest request) {
        return handleExceptionInternal(ex, MessageResponse.apiError(ex.getMessage()), new HttpHeaders(), HttpStatus.NOT_FOUND, request);
    }

    @ExceptionHandler(value = {ItemExistedException.class, IllegalArgumentException.class})
    protected ResponseEntity handleNotAcceptable(RuntimeException ex, WebRequest request) {
        return handleExceptionInternal(ex, MessageResponse.apiError(ex.getMessage()), new HttpHeaders(), HttpStatus.NOT_ACCEPTABLE, request);
    }

    @ExceptionHandler(value = {RuntimeException.class})
    protected ResponseEntity handleBadRequest(RuntimeException e, WebRequest request) {
        return handleExceptionInternal(e, MessageResponse.apiError(e.getMessage()), new HttpHeaders(), HttpStatus.BAD_REQUEST, request);
    }

    @ExceptionHandler(value = {Exception.class})
    protected ResponseEntity handleBadRequest(Exception e, WebRequest request) {
        return handleExceptionInternal(e, MessageResponse.apiError(e.getMessage()), new HttpHeaders(), HttpStatus.INTERNAL_SERVER_ERROR, request);
    }

    @ExceptionHandler(value = {NotActiveException.class})
    protected ResponseEntity handleBadRequest(NotActiveException e, WebRequest request) {
        return handleExceptionInternal(e, MessageResponse.apiError(e.getMessage()), new HttpHeaders(), HttpStatus.UNAUTHORIZED, request);
    }
}
