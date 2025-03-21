package com.openmind.neh.app.dtos.request;

import com.openmind.neh.security.User.DTOs.UserRequest;
import lombok.*;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@EqualsAndHashCode(callSuper = true)
@SuperBuilder
@NoArgsConstructor
public class AdminDtoRequest extends UserRequest {
}
