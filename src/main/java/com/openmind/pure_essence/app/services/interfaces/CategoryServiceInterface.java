package com.openmind.pure_essence.app.services.interfaces;

import com.openmind.pure_essence.app.dtos.request.CategoryDtoRequest;
import com.openmind.pure_essence.app.dtos.response.CategoryDtoResponse;
import com.openmind.pure_essence.shareable.CrudInterface;

import java.util.UUID;

public interface CategoryServiceInterface extends CrudInterface<CategoryDtoRequest, CategoryDtoResponse , UUID> {
}
