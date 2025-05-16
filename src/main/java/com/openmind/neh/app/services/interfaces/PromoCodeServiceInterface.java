package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.dtos.request.PromoCodeDtoRequest;
import com.openmind.neh.app.dtos.response.PromoCodeDtoResponse;
import com.openmind.neh.shareable.CrudInterface;
import java.util.List;
import java.util.UUID;

public interface PromoCodeServiceInterface extends CrudInterface<PromoCodeDtoRequest, PromoCodeDtoResponse, UUID> {
    PromoCodeDtoResponse validatePromoCode(String code);
    PromoCodeDtoResponse togglePromoCode(UUID id);
    List<PromoCodeDtoResponse> getActivePromoCodes();
    List<PromoCodeDtoResponse> getInfluencerPromoCodes(UUID influencerId);
    boolean incrementPromoCodeUsage(UUID id);
} 