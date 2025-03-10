package com.openmind.pure_essence.app.services.implimetations;

import com.openmind.pure_essence.app.dtos.request.CategoryDtoRequest;
import com.openmind.pure_essence.app.dtos.response.CategoryDtoResponse;
import com.openmind.pure_essence.app.entities.Category;
import com.openmind.pure_essence.app.repositories.CategoryRepository;
import com.openmind.pure_essence.app.services.interfaces.CategoryServiceInterface;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class CategoryService  implements CategoryServiceInterface {
    private final CategoryRepository categoryRepository;
    private final ModelMapper modelMapper;

    @Override
    public CategoryDtoResponse create(CategoryDtoRequest categoryDtoRequest) {
        Category category =  categoryRepository.save(modelMapper.map(categoryDtoRequest,Category.class));
        return modelMapper.map(category,CategoryDtoResponse.class);
    }

    @Override
    public CategoryDtoResponse update(CategoryDtoRequest categoryDtoRequest, UUID uuid) {
        Optional<Category> category = categoryRepository.findById(uuid);
        return category.map(c ->{
            categoryDtoRequest.setId(uuid);
            return  create(categoryDtoRequest);
        }).orElse(null);
    }

    @Override
    public Integer delete(UUID uuid) {
        Category category = categoryRepository.findById(uuid).orElse(null);
        if(category != null) {
            categoryRepository.delete(category);
            return 1;
        }
        return 0;
    }

    @Override
    public List<CategoryDtoResponse> getAll() {
        return categoryRepository.findAll().stream().map(category -> modelMapper.map(category, CategoryDtoResponse.class)).collect(Collectors.toList());
    }

    @Override
    public CategoryDtoResponse getOne(UUID uuid) {
        return modelMapper.map(categoryRepository.findById(uuid).orElse(null),CategoryDtoResponse.class);
    }
}
