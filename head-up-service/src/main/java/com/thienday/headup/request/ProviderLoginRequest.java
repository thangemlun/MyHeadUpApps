package com.thienday.headup.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProviderLoginRequest implements Serializable {
    private String avatar;
    private String name;
}
