package com.openmind.neh.app.services.implimetations;

import com.openmind.neh.app.dtos.request.CommissionDtoRequest;
import com.openmind.neh.app.dtos.response.CommissionDtoResponse;
import com.openmind.neh.app.entities.Commission;
import com.openmind.neh.app.entities.Influencer;
import com.openmind.neh.app.entities.Order;
import com.openmind.neh.app.repositories.CommissionRepository;
import com.openmind.neh.app.repositories.InfluencerRepository;
import com.openmind.neh.app.repositories.OrderRepository;
import com.openmind.neh.app.services.interfaces.CommissionServiceInterface;
import com.openmind.neh.config.ResourceNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommissionService implements CommissionServiceInterface {

    private final CommissionRepository commissionRepository;
    private final InfluencerRepository influencerRepository;
    private final OrderRepository orderRepository;
    private final ModelMapper modelMapper;

    @Override
    public CommissionDtoResponse create(CommissionDtoRequest request) {
        Commission commission = mapToEntity(request);
        return modelMapper.map(commissionRepository.save(commission), CommissionDtoResponse.class);
    }

    @Override
    public CommissionDtoResponse update(CommissionDtoRequest request, UUID id) {
        Commission existing = commissionRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Commission not found"));

        Commission updated = mapToEntity(request);
        updated.setId(id);
        updated.setCreatedAt(existing.getCreatedAt());
        return modelMapper.map(commissionRepository.save(updated), CommissionDtoResponse.class);
    }

    @Override
    public Integer delete(UUID id) {
        if (commissionRepository.existsById(id)) {
            commissionRepository.deleteById(id);
            return 1;
        }
        return 0;
    }

    @Override
    public List<CommissionDtoResponse> getAll() {
        return commissionRepository.findAll().stream()
                .map(c -> modelMapper.map(c, CommissionDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    public CommissionDtoResponse getOne(UUID id) {
        return commissionRepository.findById(id)
                .map(c -> modelMapper.map(c, CommissionDtoResponse.class))
                .orElse(null);
    }

    @Override
    public List<CommissionDtoResponse> getByInfluencerId(UUID influencerId) {
        return commissionRepository.findByInfluencerId(influencerId).stream()
                .map(c -> modelMapper.map(c, CommissionDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<CommissionDtoResponse> getUnpaidCommissions() {
        return commissionRepository.findByIsPaidFalse().stream()
                .map(c -> modelMapper.map(c, CommissionDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<CommissionDtoResponse> getPaidCommissions() {
        return commissionRepository.findByIsPaidTrue().stream()
                .map(c -> modelMapper.map(c, CommissionDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public CommissionDtoResponse markAsPaid(UUID commissionId) {
        Commission commission = commissionRepository.findById(commissionId)
                .orElseThrow(() -> new ResourceNotFoundException("Commission not found"));

        commission.setIsPaid(true);
        commission.setPaidAt(LocalDateTime.now());
        return modelMapper.map(commissionRepository.save(commission), CommissionDtoResponse.class);
    }

    @Override
    public Double getTotalCommission(UUID influencerId) {
        var value =  commissionRepository.getTotalCommission(influencerId);
        return value != null ?value:0.0;
    }

    @Override
    public Double getTotalUnpaidCommission(UUID influencerId) {
        var value =  commissionRepository.getTotalUnpaidCommission(influencerId);
        return value != null ?value:0.0;
    }


    private Commission mapToEntity(CommissionDtoRequest request) {
        Influencer influencer = influencerRepository.findById(request.getInfluencerId())
                .orElseThrow(() -> new ResourceNotFoundException("Influencer not found"));

        Order order = orderRepository.findById(request.getOrderId())
                .orElseThrow(() -> new ResourceNotFoundException("Order not found"));

        Commission commission = new Commission();
        commission.setInfluencer(influencer);
        commission.setOrder(order);
        commission.setAmount(request.getAmount());
        commission.setIsPaid(request.getIsPaid() != null ? request.getIsPaid() : false);
        return commission;
    }

    @Override
    @Transactional
    public List<CommissionDtoResponse> markAllAsPaidByInfluencerId(UUID influencerId) {
        List<Commission> commissions = commissionRepository.findByInfluencer_IdAndIsPaidFalse(influencerId);

        for (Commission commission : commissions) {
            commission.setIsPaid(true);
            commission.setPaidAt(LocalDateTime.now());
        }

        commissionRepository.saveAll(commissions);

        return commissions.stream()
                .map(c -> modelMapper.map(c, CommissionDtoResponse.class))
                .collect(Collectors.toList());
    }

}
