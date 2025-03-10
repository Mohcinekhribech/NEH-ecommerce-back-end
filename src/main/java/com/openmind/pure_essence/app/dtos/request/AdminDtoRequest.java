package com.openmind.pure_essence.app.dtos.request;

import com.openmind.pure_essence.security.User.DTOs.UserRequest;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@EqualsAndHashCode(callSuper = true)
@Setter
@Getter
public class AdminDtoRequest extends UserRequest {
}
