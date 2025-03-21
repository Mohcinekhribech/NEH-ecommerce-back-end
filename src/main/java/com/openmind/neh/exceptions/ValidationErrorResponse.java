package com.openmind.neh.exceptions;

import lombok.Data;

import java.util.List;

@Data
public class ValidationErrorResponse {
    private List<String> errors;
}
