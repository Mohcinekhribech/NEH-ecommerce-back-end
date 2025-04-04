package com.openmind.neh.app.services.implimetations;

import com.openmind.neh.app.dtos.request.OrderedProductDtoRequest;
import com.openmind.neh.app.dtos.response.OrderedProductDtoResponse;
import com.openmind.neh.app.entities.Order;
import com.openmind.neh.app.entities.OrderedProduct;
import com.openmind.neh.app.entities.Product;
import com.openmind.neh.app.entities.embededId.OrderedProductId;
import com.openmind.neh.app.repositories.OrderRepository;
import com.openmind.neh.app.repositories.OrderedProductRepository;
import com.openmind.neh.app.repositories.ProductRepository;
import com.openmind.neh.app.services.interfaces.OrderedProductServiceInterface;
import com.openmind.neh.config.ResourceNotFoundException;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@AllArgsConstructor
public class OrderedProductService implements OrderedProductServiceInterface {
    private final OrderedProductRepository orderedProductRepository ;
    private final ProductRepository productRepository ;
    private final OrderRepository orderRepository ;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public OrderedProductDtoResponse create(OrderedProductDtoRequest orderedProductDtoRequest) {
        Product product = productRepository.findById(orderedProductDtoRequest.getProductId())
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));
        product.setQuantity(product.getQuantity() - orderedProductDtoRequest.getQuantity());
        productRepository.save(product);

        Order order = orderRepository.findById(orderedProductDtoRequest.getOrderId())
                .orElseThrow(() -> new ResourceNotFoundException("Order not found"));

        // Mapping DTO to Entity
        OrderedProduct orderedProduct = modelMapper.map(orderedProductDtoRequest, OrderedProduct.class);

        // Setting Composite Key
        OrderedProductId id = new OrderedProductId(orderedProductDtoRequest.getOrderId(), orderedProductDtoRequest.getProductId());
        orderedProduct.setId(id);

        // Calculating total price
        orderedProduct.setTotalPrice(orderedProduct.getUnitPrice() * orderedProduct.getQuantity());

        // Saving to DB
        OrderedProduct savedOrderedProduct = orderedProductRepository.save(orderedProduct);

        // Mapping back to DTO
        return modelMapper.map(savedOrderedProduct, OrderedProductDtoResponse.class);
    }

    @Override
    public OrderedProductDtoResponse update(OrderedProductDtoRequest orderedProductDtoRequest, OrderedProductId orderedProductId) {
        return null;
    }

    @Override
    public Integer delete(OrderedProductId orderedProductId) {
        return 0;
    }

    @Override
    public List<OrderedProductDtoResponse> getAll() {
        return List.of();
    }

    @Override
    public OrderedProductDtoResponse getOne(OrderedProductId orderedProductId) {
        return null;
    }
}
