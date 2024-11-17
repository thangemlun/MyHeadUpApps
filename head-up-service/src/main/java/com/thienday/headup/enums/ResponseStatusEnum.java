package com.thienday.headup.enums;

public enum ResponseStatusEnum {
    SUCCESS(true),
    FAILED(false)
    ;
    private boolean status;
    ResponseStatusEnum(boolean status){
        this.status = status;
    }
    public boolean getStatus(){
        return this.status;
    }
}
