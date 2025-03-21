package com.openmind.neh.app.dtos.response;

import com.openmind.neh.security.User.DTOs.UserDTO;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
public class AdminDtoResponse extends UserDTO {
}
