package com.openmind.neh.app.controllers;

import com.openmind.neh.app.dtos.request.TagDtoRequest;
import com.openmind.neh.app.dtos.response.TagDtoResponse;
import com.openmind.neh.app.services.interfaces.TagServiceInterface;
import com.openmind.neh.shareable.CrudController;
import com.openmind.neh.shareable.ResponseMessage;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("api/tags")
public class TagController extends CrudController<TagDtoRequest , TagDtoResponse , UUID,  TagServiceInterface> {
    public TagController(TagServiceInterface tagServiceInterface, ResponseMessage responseMessage) {
        super(tagServiceInterface, responseMessage);
    }
}
