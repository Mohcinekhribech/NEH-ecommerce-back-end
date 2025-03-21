package com.openmind.neh.app.dtos.response;

import com.openmind.neh.security.User.DTOs.UserDTO;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
public class ClientDtoResponse extends UserDTO {
    private LocalDate registrationDate;
}
