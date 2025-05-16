package com.openmind.neh.app.controllers;

import com.openmind.neh.app.dtos.request.InfluencerDtoRequest;
import com.openmind.neh.app.dtos.response.InfluencerDtoResponse;
import com.openmind.neh.app.services.interfaces.InfluencerServiceInterface;
import com.openmind.neh.shareable.CrudController;
import com.openmind.neh.shareable.ResponseMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/influencers")
public class InfluencerController extends CrudController<InfluencerDtoRequest, InfluencerDtoResponse, UUID, InfluencerServiceInterface> {

    public InfluencerController(InfluencerServiceInterface influencerService, ResponseMessage responseMessage) {
        super(influencerService, responseMessage);
    }

    @PutMapping("/{id}/toggle")
    public ResponseEntity<InfluencerDtoResponse> toggleInfluencerStatus(@PathVariable UUID id) {
        try {
            InfluencerDtoResponse influencer = service.toggleInfluencerStatus(id);
            return ResponseEntity.ok(influencer);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/active")
    public ResponseEntity<List<InfluencerDtoResponse>> getActiveInfluencers() {
        List<InfluencerDtoResponse> influencers = service.getActiveInfluencers();
        return ResponseEntity.ok(influencers);
    }

    @GetMapping("/{id}/commissions")
    public ResponseEntity<InfluencerDtoResponse> getInfluencerWithCommissions(@PathVariable UUID id) {
        try {
            InfluencerDtoResponse influencer = service.getInfluencerWithCommissions(id);
            return ResponseEntity.ok(influencer);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
} 