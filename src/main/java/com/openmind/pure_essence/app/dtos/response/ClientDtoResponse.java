package com.openmind.pure_essence.app.dtos.response;

import com.openmind.pure_essence.security.User.DTOs.UserDTO;
import lombok.Data;
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
