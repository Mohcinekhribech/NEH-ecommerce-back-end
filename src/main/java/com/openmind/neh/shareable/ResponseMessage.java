package com.openmind.neh.shareable;

import lombok.Data;
import org.springframework.stereotype.Component;

@Component
@Data
public class ResponseMessage {
    private String message;
}
