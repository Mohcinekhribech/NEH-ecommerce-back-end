package com.openmind.pure_essence.app.services.implimetations;

import com.openmind.pure_essence.app.dtos.request.OrderDtoRequest;
import com.openmind.pure_essence.app.dtos.request.OrderedProductDtoRequest;
import com.openmind.pure_essence.app.dtos.response.*;
import com.openmind.pure_essence.app.dtos.response.OrderDtoResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.openmind.pure_essence.app.entities.Client;
import com.openmind.pure_essence.app.entities.Order;
import com.openmind.pure_essence.app.entities.OrderedProduct;
import com.openmind.pure_essence.app.entities.enums.OrderStatus;
import com.openmind.pure_essence.app.entities.enums.PaymentStatus;
import com.openmind.pure_essence.app.repositories.ClientRepository;
import com.openmind.pure_essence.app.repositories.OrderRepository;
import com.openmind.pure_essence.app.services.interfaces.OrderServiceInterface;
import com.openmind.pure_essence.app.services.interfaces.OrderedProductServiceInterface;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService implements OrderServiceInterface {
    private final OrderRepository orderRepository;
    private final OrderedProductServiceInterface orderedProductService;
    private final ClientRepository clientRepository;
    private final ModelMapper modelMapper;
    private Order order;

    @Transactional
    @Override
    public OrderDtoResponse create(OrderDtoRequest orderDtoRequest) {
        Optional<Client> client = clientRepository.findById(orderDtoRequest.getClientId());
        return client.map(c->{
            order = modelMapper.map(orderDtoRequest, Order.class);
            order.setClient(c);
            order =  orderRepository.save(order);
            List<OrderedProductDtoRequest> orderedProductDtoRequests = orderDtoRequest.getOrderedProducts();
            List<OrderedProductDtoResponse> orderedProducts = orderedProductDtoRequests.stream().map(orderedProduct -> {
                orderedProduct.setOrderId(order.getId());
                return  orderedProductService.create(orderedProduct);
            }).toList();
            OrderDtoResponse orderDtoResponse = modelMapper.map(order, OrderDtoResponse.class);
            orderDtoResponse.setOrderedProducts(orderedProducts);
            return orderDtoResponse;
        }).orElse(null);
    }

    @Override
    public OrderDtoResponse update(OrderDtoRequest orderDtoRequest, UUID uuid) {
        Optional<Order> order = orderRepository.findById(uuid);
        return order.map(c ->{
            orderDtoRequest.setId(uuid);
            return  create(orderDtoRequest);
        }).orElse(null);
    }

    @Override
    public Integer delete(UUID uuid) {
        Order order = orderRepository.findById(uuid).orElse(null);
        if(order != null) {
            orderRepository.delete(order);
            return 1;
        }
        return 0;
    }

    @Override
    public List<OrderDtoResponse> getAll() {
        return orderRepository.findAll().stream().map(order -> modelMapper.map(order, OrderDtoResponse.class)).collect(Collectors.toList());
    }

    @Override
    public Page<OrderDtoResponse> getAllPageable(Pageable pageable) {
        return orderRepository.findAll(pageable)
                .map(order -> modelMapper.map(order, OrderDtoResponse.class));    }

    @Override
    public OrderDtoResponse getOne(UUID uuid) {
        return modelMapper.map(orderRepository.findById(uuid).orElse(null), OrderDtoResponse.class);
    }

    @Override
    public Boolean updatePaymentStatus(PaymentStatus paymentStatus,UUID orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        return order.map(o->{
            o.setPaymentStatus(paymentStatus);
            orderRepository.save(o);
            return true;
        }).orElse(false);
    }

    @Override
    public Boolean updateOrderStatus(OrderStatus orderStatus, UUID orderId) {
        Optional<Order> order = orderRepository.findById(orderId);
        return order.map(o->{
            o.setStatus(orderStatus);
            orderRepository.save(o);
            return true;
        }).orElse(false);
    }

    @Override
    public List<OrderDtoResponse> getRecentOrders() {
        return orderRepository.findRecentOrders().stream().map(order -> modelMapper.map(order, OrderDtoResponse.class)).collect(Collectors.toList());
    }

    @Override
    public List<OrderDtoResponse> getOrdersByClientId(UUID clientId) {
        return orderRepository.getOrderByClient_Id(clientId).stream().map(order -> modelMapper.map(order, OrderDtoResponse.class)).collect(Collectors.toList());
    }

}
