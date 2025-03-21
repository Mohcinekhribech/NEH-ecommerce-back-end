package com.openmind.neh.security.User.DTOs;

import com.openmind.neh.app.entities.enums.AgeRange;
import com.openmind.neh.security.User.Role;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.time.LocalDate;
import java.util.UUID;

@Data
public class UserDTO {
    private UUID id;

    protected String profilePic;

    @NotBlank(message = "email cannot be blank")
    @Size(max = 1000, message = "Email must not exceed 1000 characters")
    private String email;
    private String firstName;
    private String lastName;
    private String phone;
    private String address;
    private String city;
    private String zipCode;
    private String country;

    private Role role;
    private AgeRange ageRange;
}
