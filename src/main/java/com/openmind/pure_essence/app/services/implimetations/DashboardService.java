package com.openmind.pure_essence.app.services.implimetations;

import com.openmind.pure_essence.app.dtos.response.DashboardStatsDto;
import com.openmind.pure_essence.app.repositories.OrderRepository;
import com.openmind.pure_essence.app.services.interfaces.DashboardServiceInterface;
import com.openmind.pure_essence.security.User.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

@Service
@RequiredArgsConstructor
public class DashboardService implements DashboardServiceInterface {

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    @Override
    public DashboardStatsDto getDashboardStats() {
        // Revenue
        var totalRevenue1 = orderRepository.calculateTotalRevenue();
        double totalRevenue = totalRevenue1 == null ? 0.0 : totalRevenue1;
        var previousRevenue1 = orderRepository.calculateRevenueForPeriod(LocalDateTime.now().minus(30, ChronoUnit.DAYS));
        double previousRevenue = previousRevenue1 == null?0.0:previousRevenue1;
        double revenueChange = (previousRevenue == 0) ? 0 : ((totalRevenue - previousRevenue) / previousRevenue) * 100;

        // Orders
        int totalOrders = orderRepository.countTotalOrders();
        int previousOrders = orderRepository.countOrdersForPeriod(LocalDateTime.now().minus(30, ChronoUnit.DAYS));
        double ordersChange = (previousOrders == 0) ? 0 : ((totalOrders - previousOrders) / (double) previousOrders) * 100;

        // New Customers
        int newCustomers = userRepository.countNewCustomers();
        int previousNewCustomers = userRepository.countNewCustomersForPeriod(LocalDateTime.now().minus(30, ChronoUnit.DAYS));
        double customersChange = (previousNewCustomers == 0) ? 0 : ((newCustomers - previousNewCustomers) / (double) previousNewCustomers) * 100;

        // Conversion Rate
        double conversionRate = (totalOrders == 0) && (newCustomers == 0) ? 0 : (totalOrders / (double) newCustomers) * 100;

        return new DashboardStatsDto(totalRevenue, revenueChange, totalOrders, ordersChange, newCustomers, customersChange, conversionRate);
    }
}