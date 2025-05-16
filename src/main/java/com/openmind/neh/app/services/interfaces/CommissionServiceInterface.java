package com.openmind.neh.app.services.interfaces;

import com.openmind.neh.app.dtos.request.CommissionDtoRequest;
import com.openmind.neh.app.dtos.response.CommissionDtoResponse;
import com.openmind.neh.shareable.CrudInterface;

import java.util.List;
import java.util.UUID;

public interface CommissionServiceInterface extends CrudInterface<CommissionDtoRequest, CommissionDtoResponse, UUID> {
    List<CommissionDtoResponse> getByInfluencerId(UUID influencerId);
    List<CommissionDtoResponse> getUnpaidCommissions();
    List<CommissionDtoResponse> getPaidCommissions();
    CommissionDtoResponse markAsPaid(UUID commissionId);
    Double getTotalCommission(UUID influencerId);
    Double getTotalUnpaidCommission(UUID influencerId);
    List<CommissionDtoResponse> markAllAsPaidByInfluencerId(UUID influencerId);

}

