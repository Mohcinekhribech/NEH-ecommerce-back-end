package com.openmind.pure_essence.app.services.implimetations;

import com.openmind.pure_essence.app.dtos.request.TagDtoRequest;
import com.openmind.pure_essence.app.dtos.request.TagDtoRequest;
import com.openmind.pure_essence.app.dtos.response.TagDtoResponse;
import com.openmind.pure_essence.app.dtos.response.TagDtoResponse;
import com.openmind.pure_essence.app.entities.Tag;
import com.openmind.pure_essence.app.repositories.TagRepository;
import com.openmind.pure_essence.app.repositories.TagRepository;
import com.openmind.pure_essence.app.services.interfaces.TagServiceInterface;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class TagService implements TagServiceInterface {
    private final TagRepository tagRepository;
    private final ModelMapper modelMapper;

    @Override
    public TagDtoResponse create(TagDtoRequest tagDtoRequest) {
        Tag tag =  tagRepository.save(modelMapper.map(tagDtoRequest,Tag.class));
        return modelMapper.map(tag,TagDtoResponse.class);
    }

    @Override
    public TagDtoResponse update(TagDtoRequest tagDtoRequest, UUID uuid) {
        Optional<Tag> tag = tagRepository.findById(uuid);
        return tag.map(c ->{
            tagDtoRequest.setId(uuid);
            return  create(tagDtoRequest);
        }).orElse(null);
    }

    @Override
    public Integer delete(UUID uuid) {
        if (!tagRepository.existsById(uuid)) {
            return 0;
        }
        tagRepository.deleteById(uuid);
        return 1;
    }


    @Override
    public List<TagDtoResponse> getAll() {
        return tagRepository.findAll().stream().map(tag -> modelMapper.map(tag, TagDtoResponse.class)).collect(Collectors.toList());
    }

    @Override
    public TagDtoResponse getOne(UUID uuid) {
        return modelMapper.map(tagRepository.findById(uuid).orElse(null),TagDtoResponse.class);
    }
}
