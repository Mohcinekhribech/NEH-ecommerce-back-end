package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.entities.Product;

import java.util.List;
import java.util.UUID;

public interface ProductTagServiceInterface {
    Integer createAll(Product product, List<UUID> tagIds);
}
