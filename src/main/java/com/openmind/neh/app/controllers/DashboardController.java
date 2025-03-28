package com.openmind.neh.app.controllers;

import com.openmind.neh.app.dtos.response.DashboardStatsDto;
import com.openmind.neh.app.services.interfaces.DashboardServiceInterface;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/dashboard")
public class DashboardController {
    private final DashboardServiceInterface dashboardService;

    @GetMapping("/stats")
    public ResponseEntity<DashboardStatsDto> getDashboardStats() {
        return ResponseEntity.ok().body(dashboardService.getDashboardStats());
    }
}
