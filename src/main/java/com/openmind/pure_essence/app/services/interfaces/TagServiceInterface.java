package com.openmind.pure_essence.app.services.interfaces;

import com.openmind.pure_essence.app.dtos.request.TagDtoRequest;
import com.openmind.pure_essence.app.dtos.response.TagDtoResponse;
import com.openmind.pure_essence.shareable.CrudInterface;

import java.util.UUID;

public interface TagServiceInterface extends CrudInterface<TagDtoRequest , TagDtoResponse , UUID> {
}
