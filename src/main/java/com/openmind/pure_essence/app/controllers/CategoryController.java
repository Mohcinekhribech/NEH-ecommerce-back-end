package com.openmind.pure_essence.app.controllers;

import com.openmind.pure_essence.app.dtos.request.CategoryDtoRequest;
import com.openmind.pure_essence.app.dtos.response.CategoryDtoResponse;
import com.openmind.pure_essence.app.services.interfaces.CategoryServiceInterface;
import com.openmind.pure_essence.shareable.CrudController;
import com.openmind.pure_essence.shareable.ResponseMessage;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequestMapping("api/category")
public class CategoryController extends CrudController<CategoryDtoRequest , CategoryDtoResponse , UUID , CategoryServiceInterface> {
    public CategoryController(CategoryServiceInterface categoryServiceInterface, ResponseMessage responseMessage) {
        super(categoryServiceInterface, responseMessage);
    }
}
