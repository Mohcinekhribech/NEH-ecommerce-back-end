package com.openmind.neh.config;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;

import java.io.IOException;
import java.text.DecimalFormat;

public class CustomNumberSerializer extends ToStringSerializer {

    private static final DecimalFormat formatter = new DecimalFormat("0.00");

    @Override
    public void serialize(Object value, JsonGenerator gen, SerializerProvider provider) throws IOException {
        if (value instanceof Double) {
            gen.writeString(formatter.format(value));  // Format the number to 2 decimal places
        } else {
            super.serialize(value, gen, provider);  // Default serialization for other types
        }
    }
}

