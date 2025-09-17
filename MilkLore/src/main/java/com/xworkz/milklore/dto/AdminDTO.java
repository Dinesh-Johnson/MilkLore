package com.xworkz.milklore.dto;

import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Data
public class AdminDTO {

    private Integer adminID;

    @NotBlank
    private String adminName;

    @NotBlank
    @Pattern(regexp = "^[0-9]{10}$")
    private String mobileNumber;

    @NotBlank
    @Email
    private String email;

    @NotBlank
    @Size(min = 5,max = 15)
    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$")
    private String password;

    @NotBlank
    @Size(min = 5,max = 15)
    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$")
    private String confirmPassword;

    private String profilePath;

    private boolean blockedStatus;


}
