package com.openmind.neh.app.controllers;

import com.openmind.neh.app.dtos.request.PromoCodeDtoRequest;
import com.openmind.neh.app.dtos.response.PromoCodeDtoResponse;
import com.openmind.neh.app.services.interfaces.PromoCodeServiceInterface;
import com.openmind.neh.shareable.CrudController;
import com.openmind.neh.shareable.ResponseMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/promo-codes")
public class PromoCodeController extends CrudController<PromoCodeDtoRequest, PromoCodeDtoResponse, UUID, PromoCodeServiceInterface> {

    public PromoCodeController(PromoCodeServiceInterface promoCodeService, ResponseMessage responseMessage) {
        super(promoCodeService, responseMessage);
    }

    @GetMapping("/validate/{code}")
    public ResponseEntity<PromoCodeDtoResponse> validatePromoCode(@PathVariable String code) {
        try {
            PromoCodeDtoResponse promoCode = service.validatePromoCode(code);
            return ResponseEntity.ok(promoCode);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping("/{id}/toggle")
    public ResponseEntity<PromoCodeDtoResponse> togglePromoCode(@PathVariable UUID id) {
        try {
            PromoCodeDtoResponse promoCode = service.togglePromoCode(id);
            return ResponseEntity.ok(promoCode);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/active")
    public ResponseEntity<List<PromoCodeDtoResponse>> getActivePromoCodes() {
        List<PromoCodeDtoResponse> promoCodes = service.getActivePromoCodes();
        return ResponseEntity.ok(promoCodes);
    }

    @GetMapping("/influencer/{influencerId}")
    public ResponseEntity<List<PromoCodeDtoResponse>> getInfluencerPromoCodes(@PathVariable UUID influencerId) {
        List<PromoCodeDtoResponse> promoCodes = service.getInfluencerPromoCodes(influencerId);
        return ResponseEntity.ok(promoCodes);
    }
} 