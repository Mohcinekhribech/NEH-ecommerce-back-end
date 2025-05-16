package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.dtos.request.InfluencerDtoRequest;
import com.openmind.neh.app.dtos.response.InfluencerDtoResponse;
import com.openmind.neh.shareable.CrudInterface;
import java.util.List;
import java.util.UUID;

public interface InfluencerServiceInterface extends CrudInterface<InfluencerDtoRequest, InfluencerDtoResponse, UUID> {
    InfluencerDtoResponse toggleInfluencerStatus(UUID id);
    List<InfluencerDtoResponse> getActiveInfluencers();
    InfluencerDtoResponse getInfluencerWithCommissions(UUID id);
    boolean calculateAndSaveCommission(UUID influencerId, UUID orderId, Double orderAmount);
} 