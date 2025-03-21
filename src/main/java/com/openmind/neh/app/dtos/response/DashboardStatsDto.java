package com.openmind.neh.app.dtos.response;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.openmind.neh.config.CustomNumberSerializer;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class DashboardStatsDto {
    private double totalRevenue;   // Total Revenue
    @JsonSerialize(using = CustomNumberSerializer.class)
    private double revenueChange;  // Percentage change in Revenue
    private int totalOrders;       // Total Orders
    @JsonSerialize(using = CustomNumberSerializer.class)
    private double ordersChange;   // Percentage change in Orders
    private int newCustomers;      // New Customers
    @JsonSerialize(using = CustomNumberSerializer.class)
    private double customersChange; // Percentage change in New Customers
    @JsonSerialize(using = CustomNumberSerializer.class)
    private double conversionRate;  // Conversion Rate
}