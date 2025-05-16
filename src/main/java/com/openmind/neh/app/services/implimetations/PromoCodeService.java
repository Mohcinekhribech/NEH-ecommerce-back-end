package com.openmind.neh.app.services.implimetations;

import com.openmind.neh.app.dtos.request.PromoCodeDtoRequest;
import com.openmind.neh.app.dtos.response.PromoCodeDtoResponse;
import com.openmind.neh.app.entities.Influencer;
import com.openmind.neh.app.entities.PromoCode;
import com.openmind.neh.app.repositories.InfluencerRepository;
import com.openmind.neh.app.repositories.PromoCodeRepository;
import com.openmind.neh.app.services.interfaces.PromoCodeServiceInterface;
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
public class PromoCodeService implements PromoCodeServiceInterface {
    private final PromoCodeRepository promoCodeRepository;
    private final InfluencerRepository influencerRepository;
    private final ModelMapper modelMapper;

    @Override
    @Transactional
    public PromoCodeDtoResponse create(PromoCodeDtoRequest promoCodeDtoRequest) {
        if (promoCodeRepository.existsByCode(promoCodeDtoRequest.getCode())) {
            throw new IllegalArgumentException("Promo code already exists");
        }

        Influencer influencer = influencerRepository.findById(promoCodeDtoRequest.getInfluencerId())
                .orElseThrow(() -> new ResourceNotFoundException("Influencer not found"));

        PromoCode promoCode = modelMapper.map(promoCodeDtoRequest, PromoCode.class);
        promoCode.setInfluencer(influencer);
        promoCode.setCurrentUses(0);

        PromoCode savedPromoCode = promoCodeRepository.save(promoCode);
        return modelMapper.map(savedPromoCode, PromoCodeDtoResponse.class);
    }

    @Override
    public PromoCodeDtoResponse update(PromoCodeDtoRequest promoCodeDtoRequest, UUID uuid) {
        PromoCode existingPromoCode = promoCodeRepository.findById(uuid)
                .orElseThrow(() -> new ResourceNotFoundException("Promo code not found"));

        if (!existingPromoCode.getCode().equals(promoCodeDtoRequest.getCode()) &&
            promoCodeRepository.existsByCode(promoCodeDtoRequest.getCode())) {
            throw new IllegalArgumentException("Promo code already exists");
        }

        Influencer influencer = influencerRepository.findById(promoCodeDtoRequest.getInfluencerId())
                .orElseThrow(() -> new ResourceNotFoundException("Influencer not found"));

        PromoCode promoCode = modelMapper.map(promoCodeDtoRequest, PromoCode.class);
        promoCode.setId(uuid);
        promoCode.setInfluencer(influencer);
        promoCode.setCurrentUses(existingPromoCode.getCurrentUses());

        PromoCode updatedPromoCode = promoCodeRepository.save(promoCode);
        return modelMapper.map(updatedPromoCode, PromoCodeDtoResponse.class);
    }

    @Override
    public Integer delete(UUID uuid) {
        if (promoCodeRepository.existsById(uuid)) {
            promoCodeRepository.deleteById(uuid);
            return 1;
        }
        return 0;
    }

    @Override
    public List<PromoCodeDtoResponse> getAll() {
        return promoCodeRepository.findAll().stream()
                .map(promoCode -> modelMapper.map(promoCode, PromoCodeDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    public PromoCodeDtoResponse getOne(UUID uuid) {
        return promoCodeRepository.findById(uuid)
                .map(promoCode -> modelMapper.map(promoCode, PromoCodeDtoResponse.class))
                .orElse(null);
    }

    @Override
    public PromoCodeDtoResponse validatePromoCode(String code) {
        PromoCode promoCode = promoCodeRepository.findByCode(code)
                .orElseThrow(() -> new ResourceNotFoundException("Promo code not found"));

        if (!promoCode.getIsActive()) {
            throw new IllegalArgumentException("Promo code is inactive");
        }

        LocalDateTime now = LocalDateTime.now();
        System.out.println(now.isBefore(promoCode.getValidFrom()) || now.isAfter(promoCode.getValidUntil()));
        if (now.isBefore(promoCode.getValidFrom()) || now.isAfter(promoCode.getValidUntil())) {
            throw new IllegalArgumentException("Promo code is not valid at this time");
        }

        if (promoCode.getCurrentUses() >= promoCode.getMaxUses()) {
            throw new IllegalArgumentException("Promo code has reached its maximum usage limit");
        }

        return modelMapper.map(promoCode, PromoCodeDtoResponse.class);
    }

    @Override
    @Transactional
    public PromoCodeDtoResponse togglePromoCode(UUID id) {
        PromoCode promoCode = promoCodeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Promo code not found"));

        promoCode.setIsActive(!promoCode.getIsActive());
        PromoCode updatedPromoCode = promoCodeRepository.save(promoCode);
        return modelMapper.map(updatedPromoCode, PromoCodeDtoResponse.class);
    }

    @Override
    public List<PromoCodeDtoResponse> getActivePromoCodes() {
        return promoCodeRepository.findActivePromoCodes(LocalDateTime.now()).stream()
                .map(promoCode -> modelMapper.map(promoCode, PromoCodeDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<PromoCodeDtoResponse> getInfluencerPromoCodes(UUID influencerId) {
        return promoCodeRepository.findByInfluencerId(influencerId).stream()
                .map(promoCode -> modelMapper.map(promoCode, PromoCodeDtoResponse.class))
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public boolean incrementPromoCodeUsage(UUID id) {
        PromoCode promoCode = promoCodeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Promo code not found"));

        if (promoCode.getCurrentUses() >= promoCode.getMaxUses()) {
            return false;
        }

        promoCode.setCurrentUses(promoCode.getCurrentUses() + 1);
        promoCodeRepository.save(promoCode);
        return true;
    }
} 