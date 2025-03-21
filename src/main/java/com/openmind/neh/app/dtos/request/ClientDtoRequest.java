package com.openmind.neh.app.dtos.request;

import com.openmind.neh.security.User.DTOs.UserRequest;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;

@EqualsAndHashCode(callSuper = true)
@Setter
@Getter
@SuperBuilder
@NoArgsConstructor
public class ClientDtoRequest extends UserRequest {
    private LocalDate registrationDate;

}
