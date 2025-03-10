package com.openmind.pure_essence.app.dtos.request;

import com.openmind.pure_essence.security.User.DTOs.UserRequest;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Setter
@Getter
public class ClientDtoRequest extends UserRequest {
    private LocalDate registrationDate;
}
