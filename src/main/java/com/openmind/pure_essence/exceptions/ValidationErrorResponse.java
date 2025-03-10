package com.openmind.pure_essence.exceptions;

import lombok.Data;

import java.util.List;

@Data
public class ValidationErrorResponse {
    private List<String> errors;
}
