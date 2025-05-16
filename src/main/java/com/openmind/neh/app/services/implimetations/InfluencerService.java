package com.openmind.neh.app.services.implimetations;

import com.openmind.neh.app.dtos.request.InfluencerDtoRequest;
import com.openmind.neh.app.dtos.response.InfluencerDtoResponse;
import com.openmind.neh.app.entities.Commission;
import com.openmind.neh.app.entities.Influencer;
import com.openmind.neh.app.entities.Order;
import com.openmind.neh.app.repositories.CommissionRepository;
import com.openmind.neh.app.repositories.InfluencerRepository;
import com.openmind.neh.app.repositories.OrderRepository;
import com.openmind.neh.app.services.interfaces.InfluencerServiceInterface;
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
public class InfluencerService implements InfluencerServiceInterface {
    private final InfluencerRepository influencerRepository;
    private final CommissionRepository commissionRepository;
    private final OrderRepository orderRepository;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public InfluencerDtoResponse create(InfluencerDtoRequest influencerDtoRequest) {
        if (influencerRepository.existsByEmail(influencerDtoRequest.getEmail())) {
            throw new IllegalArgumentException("Email already exists");
        }

        Influencer influencer = modelMapper.map(influencerDtoRequest, Influencer.class);
        Influencer savedInfluencer = influencerRepository.save(influencer);
        return modelMapper.map(savedInfluencer, InfluencerDtoResponse.class);
    }

    @Override
    public InfluencerDtoResponse update(InfluencerDtoRequest influencerDtoRequest, UUID uuid) {
        Influencer existingInfluencer = influencerRepository.findById(uuid)
                .orElseThrow(() -> new ResourceNotFoundException("Influencer not found"));

        if (!existingInfluencer.getEmail().equals(influencerDtoRequest.getEmail()) &&
            influencerRepository.existsByEmail(influencerDtoRequest.getEmail())) {
            throw new IllegalArgumentException("Email already exists");
        }

        Influencer influencer = modelMapper.map(influencerDtoRequest, Influencer.class);
        influencer.setId(uuid);
        Influencer updatedInfluencer = influencerRepository.save(influencer);
        return modelMapper.map(updatedInfluencer, InfluencerDtoResponse.class);
    }

    @Override
    public Integer delete(UUID uuid) {
        if (influencerRepository.existsById(uuid)) {
            influencerRepository.deleteById(uuid);
            return 1;
        }
        return 0;
    }

    @Override
    public List<InfluencerDtoResponse> getAll() {
        return influencerRepository.findAll().stream()
                .map(influencer -> modelMapper.map(influencer, InfluencerDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    public InfluencerDtoResponse getOne(UUID uuid) {
        return influencerRepository.findById(uuid)
                .map(influencer -> modelMapper.map(influencer, InfluencerDtoResponse.class))
                .orElse(null);
    }

    @Override
    @Transactional
    public InfluencerDtoResponse toggleInfluencerStatus(UUID id) {
        Influencer influencer = influencerRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Influencer not found"));

        influencer.setIsActive(!influencer.getIsActive());
        Influencer updatedInfluencer = influencerRepository.save(influencer);
        return modelMapper.map(updatedInfluencer, InfluencerDtoResponse.class);
    }

    @Override
    public List<InfluencerDtoResponse> getActiveInfluencers() {
        return influencerRepository.findByIsActiveTrue().stream()
                .map(influencer -> modelMapper.map(influencer, InfluencerDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    public InfluencerDtoResponse getInfluencerWithCommissions(UUID id) {
        Influencer influencer = influencerRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Influencer not found"));

        InfluencerDtoResponse response = modelMapper.map(influencer, InfluencerDtoResponse.class);
        response.setTotalCommission(commissionRepository.getTotalCommission(id));
        response.setUnpaidCommission(commissionRepository.getTotalUnpaidCommission(id));

        return response;
    }

    @Override
    @Transactional
    public boolean calculateAndSaveCommission(UUID influencerId, UUID orderId, Double orderAmount) {
        Influencer influencer = influencerRepository.findById(influencerId)
                .orElseThrow(() -> new ResourceNotFoundException("Influencer not found"));

        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new ResourceNotFoundException("Order not found"));

        Double commissionAmount = orderAmount * (influencer.getCommissionRate() / 100);

        Commission commission = new Commission();
        commission.setInfluencer(influencer);
        commission.setOrder(order);
        commission.setAmount(commissionAmount);
        commission.setIsPaid(false);

        commissionRepository.save(commission);
        return true;
    }
} 