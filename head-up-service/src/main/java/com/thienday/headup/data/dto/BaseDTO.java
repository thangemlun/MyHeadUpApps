package com.thienday.headup.data.dto;

import lombok.*;

import java.util.Date;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class BaseDTO {
    private long id;
    private String updatedBy;
    private Date updatedTime;
    private String createdBy;
    private Date createdTime;
    private Boolean isDeleted;
}
