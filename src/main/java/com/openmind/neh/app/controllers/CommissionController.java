package com.openmind.neh.app.controllers;

import com.openmind.neh.app.dtos.request.CommissionDtoRequest;
import com.openmind.neh.app.dtos.response.CommissionDtoResponse;
import com.openmind.neh.app.services.interfaces.CommissionServiceInterface;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/commissions")
@RequiredArgsConstructor
public class CommissionController {

    private final CommissionServiceInterface commissionService;

    @PostMapping
    public CommissionDtoResponse create(@Valid @RequestBody CommissionDtoRequest request) {
        return commissionService.create(request);
    }

    @PutMapping("/{id}")
    public CommissionDtoResponse update(@Valid @RequestBody CommissionDtoRequest request, @PathVariable UUID id) {
        return commissionService.update(request, id);
    }

    @DeleteMapping("/{id}")
    public Integer delete(@PathVariable UUID id) {
        return commissionService.delete(id);
    }

    @GetMapping
    public List<CommissionDtoResponse> getAll() {
        return commissionService.getAll();
    }

    @GetMapping("/{id}")
    public CommissionDtoResponse getOne(@PathVariable UUID id) {
        return commissionService.getOne(id);
    }

    @GetMapping("/influencer/{influencerId}")
    public List<CommissionDtoResponse> getByInfluencerId(@PathVariable UUID influencerId) {
        return commissionService.getByInfluencerId(influencerId);
    }

    @PatchMapping("/{id}/mark-paid")
    public CommissionDtoResponse markAsPaid(@PathVariable UUID id) {
        return commissionService.markAsPaid(id);
    }

    @GetMapping("/paid")
    public List<CommissionDtoResponse> getPaidCommissions() {
        return commissionService.getPaidCommissions();
    }

    @GetMapping("/unpaid")
    public List<CommissionDtoResponse> getUnpaidCommissions() {
        return commissionService.getUnpaidCommissions();
    }

    @GetMapping("/influencer/{influencerId}/commission-summary")
    public Map<String, Double> getCommissionSummary(@PathVariable UUID influencerId) {
        return Map.of(
                "totalCommission", commissionService.getTotalCommission(influencerId),
                "unpaidCommission", commissionService.getTotalUnpaidCommission(influencerId)
        );
    }

    @PatchMapping("/influencer/{influencerId}/mark-all-paid")
    public List<CommissionDtoResponse> markAllCommissionsAsPaid(@PathVariable UUID influencerId) {
        return commissionService.markAllAsPaidByInfluencerId(influencerId);
    }

}

