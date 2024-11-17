package com.thienday.headup.exception;

public class ItemExistedException extends RuntimeException{
    public ItemExistedException(String message) {
        super(message);
    }
}
