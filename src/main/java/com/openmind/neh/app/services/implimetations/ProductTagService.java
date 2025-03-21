package com.openmind.neh.app.services.implimetations;

import com.openmind.neh.app.entities.Product;
import com.openmind.neh.app.entities.ProductTag;
import com.openmind.neh.app.entities.Tag;
import com.openmind.neh.app.entities.embededId.ProductTagId;
import com.openmind.neh.app.repositories.ProductRepository;
import com.openmind.neh.app.repositories.ProductTagRepository;
import com.openmind.neh.app.repositories.TagRepository;
import com.openmind.neh.app.services.interfaces.ProductTagServiceInterface;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ProductTagService implements ProductTagServiceInterface {
    final private TagRepository tagRepository;
    final private ProductRepository productRepository;
    final private ProductTagRepository productTagRepository;


    @Transactional
    public Integer createAll(Product product, List<UUID> tagIds) {
        int count = 0;

        for (UUID tagId : tagIds) {
            Tag tag = tagRepository.findById(tagId)
                    .orElseThrow(() -> new RuntimeException("Tag not found"));

            // 1. Create composite key
            ProductTagId id = new ProductTagId(product.getId(), tag.getId());

            // 2. Create ProductTag and set values
            ProductTag productTag = new ProductTag();
            productTag.setId(id);                // Set composite key
            productTag.setProduct(product);     // Set product
            productTag.setTag(tag);             // Set tag

            productTagRepository.save(productTag);
            count++;
        }

        return count;
    }

}
