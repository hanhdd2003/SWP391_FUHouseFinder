package com.fuhousefinder.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Tenant {
    private int tenant_ID;
    private int user_ID;
    private String firstName;
    private String lastName;
    private String address;
    private String phone;
}
