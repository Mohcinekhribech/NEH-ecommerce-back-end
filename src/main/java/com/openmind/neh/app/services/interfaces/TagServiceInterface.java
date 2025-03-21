package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.dtos.request.TagDtoRequest;
import com.openmind.neh.app.dtos.response.TagDtoResponse;
import com.openmind.neh.shareable.CrudInterface;

import java.util.UUID;

public interface TagServiceInterface extends CrudInterface<TagDtoRequest , TagDtoResponse , UUID> {
}
