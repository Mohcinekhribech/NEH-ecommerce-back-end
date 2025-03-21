package com.openmind.neh.app.controllers;

import com.openmind.neh.app.dtos.request.CategoryDtoRequest;
import com.openmind.neh.app.dtos.response.CategoryDtoResponse;
import com.openmind.neh.app.services.interfaces.CategoryServiceInterface;
import com.openmind.neh.shareable.CrudController;
import com.openmind.neh.shareable.ResponseMessage;
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
