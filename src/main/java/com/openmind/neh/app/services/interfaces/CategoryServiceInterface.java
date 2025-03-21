package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.dtos.request.CategoryDtoRequest;
import com.openmind.neh.app.dtos.response.CategoryDtoResponse;
import com.openmind.neh.shareable.CrudInterface;

import java.util.UUID;

public interface CategoryServiceInterface extends CrudInterface<CategoryDtoRequest, CategoryDtoResponse , UUID> {
}
