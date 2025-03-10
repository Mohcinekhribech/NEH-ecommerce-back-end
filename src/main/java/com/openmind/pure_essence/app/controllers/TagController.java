package com.openmind.pure_essence.app.controllers;

import com.openmind.pure_essence.app.dtos.request.TagDtoRequest;
import com.openmind.pure_essence.app.dtos.response.TagDtoResponse;
import com.openmind.pure_essence.app.services.interfaces.TagServiceInterface;
import com.openmind.pure_essence.shareable.CrudController;
import com.openmind.pure_essence.shareable.CrudInterface;
import com.openmind.pure_essence.shareable.ResponseMessage;
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
