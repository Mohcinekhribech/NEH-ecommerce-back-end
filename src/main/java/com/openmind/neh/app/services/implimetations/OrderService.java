package com.openmind.neh.app.services.implimetations;

import com.openmind.neh.app.dtos.request.OrderDtoRequest;
import com.openmind.neh.app.dtos.request.OrderedProductDtoRequest;
import com.openmind.neh.app.dtos.response.*;
import com.openmind.neh.app.dtos.response.OrderDtoResponse;
import com.openmind.neh.app.entities.PromoCode;
import com.openmind.neh.config.ResourceNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.openmind.neh.app.entities.Client;
import com.openmind.neh.app.entities.Order;
import com.openmind.neh.app.entities.enums.OrderStatus;
import com.openmind.neh.app.entities.enums.PaymentStatus;
import com.openmind.neh.app.repositories.ClientRepository;
import com.openmind.neh.app.repositories.OrderRepository;
import com.openmind.neh.app.services.interfaces.OrderServiceInterface;
import com.openmind.neh.app.services.interfaces.OrderedProductServiceInterface;
import com.openmind.neh.app.services.interfaces.PromoCodeServiceInterface;
import com.openmind.neh.app.services.interfaces.InfluencerServiceInterface;
import jakarta.transaction.Transactional;
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
    private final PromoCodeServiceInterface promoCodeService;
    private final InfluencerServiceInterface influencerService;
    private final ModelMapper modelMapper;
    private Order order;


    @Override
    @Transactional
    public OrderDtoResponse create(OrderDtoRequest orderDtoRequest) {
        // Step 1: Get client
        Client client = clientRepository.findById(orderDtoRequest.getClientId())
                .orElseThrow(() -> new ResourceNotFoundException("Client not found"));

        // Step 2: Map order
        Order order = modelMapper.map(orderDtoRequest, Order.class);
        order.setClient(client);

        // Step 3: Promo code logic
        String promoCodeStr = orderDtoRequest.getPromoCode();
        if (promoCodeStr != null && !promoCodeStr.isBlank()  && !promoCodeStr.trim().isEmpty()) {
            PromoCodeDtoResponse promoCodeDto = promoCodeService.validatePromoCode(promoCodeStr);
            PromoCode promoCode = modelMapper.map(promoCodeDto, PromoCode.class);
            order.setPromoCode(promoCode);

            double discount = order.getTotalPrice() * (promoCodeDto.getDiscountPercentage() / 100);
            order.setDiscountAmount(discount);
            order.setFinalAmount(order.getTotalPrice() - discount);
        } else {
            order.setFinalAmount(order.getTotalPrice());
        }

        // Step 4: Save order
        order = orderRepository.save(order);

        // Step 5: Create ordered products
        Order finalOrder = order;
        List<OrderedProductDtoResponse> orderedProducts = orderDtoRequest.getOrderedProducts()
                .stream()
                .map(req -> {
                    req.setOrderId(finalOrder.getId());
                    return orderedProductService.create(req);
                })
                .toList();

        // Step 6: If promo was valid, increment usage and generate commission
        if (order.getPromoCode() != null && order.getPromoCode().getInfluencer() != null)  {
            promoCodeService.incrementPromoCodeUsage(order.getPromoCode().getId());

            influencerService.calculateAndSaveCommission(
                    order.getPromoCode().getInfluencer().getId(),
                    order.getId(),
                    order.getFinalAmount()
            );
        }
        System.out.println("haaaaaaaaaaaaaahwa"+(order.getPromoCode() != null && order.getPromoCode().getInfluencer() != null));

        // Step 7: Build response
        order.setPromoCode(null);
        OrderDtoResponse response = modelMapper.map(order, OrderDtoResponse.class);
        response.setOrderedProducts(orderedProducts);
        return response;
    }

//    public OrderDtoResponse create(OrderDtoRequest orderDtoRequest) {
//        Optional<Client> client = clientRepository.findById(orderDtoRequest.getClientId());
//        return client.map(c->{
//            order = modelMapper.map(orderDtoRequest, Order.class);
//            order.setClient(c);
//
//            // Apply promo code if provided
//            if (!orderDtoRequest.getPromoCode().isEmpty()) {
//                try {
//                    PromoCodeDtoResponse promoCode = promoCodeService.validatePromoCode(orderDtoRequest.getPromoCode());
//
//
//                    order.setPromoCode(modelMapper.map(promoCode, PromoCode.class));
//
//                    // Calculate discount
//                    Double discountAmount = order.getTotalPrice() * (promoCode.getDiscountPercentage() / 100);
//                    order.setDiscountAmount(discountAmount);
//                    order.setFinalAmount(order.getTotalPrice() - discountAmount);
//
//                    // Increment promo code usage
//                    System.out.println(promoCode.getId());
//                    promoCodeService.incrementPromoCodeUsage(promoCode.getId());
//                    order =  orderRepository.save(order);
//                    // Calculate and save commission
//                    influencerService.calculateAndSaveCommission(
//                        promoCode.getInfluencer().getId(),
//                        order.getId(),
//                        order.getFinalAmount()
//                    );
//                } catch (Exception e) {
//                    throw new IllegalArgumentException("Invalid promo code: " + e.getMessage());
//                }
//            } else {
//                order.setFinalAmount(order.getTotalPrice());
//            }
//            if (order.getId() == null) {
//                order =  orderRepository.save(order);
//            }
//            List<OrderedProductDtoRequest> orderedProductDtoRequests = orderDtoRequest.getOrderedProducts();
//            List<OrderedProductDtoResponse> orderedProducts = orderedProductDtoRequests.stream().map(orderedProduct -> {
//                orderedProduct.setOrderId(order.getId());
//                return  orderedProductService.create(orderedProduct);
//            }).toList();
//            OrderDtoResponse orderDtoResponse = modelMapper.map(order, OrderDtoResponse.class);
//            orderDtoResponse.setOrderedProducts(orderedProducts);
//            return orderDtoResponse;
//        }).orElse(null);
//    }

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
