package com.openmind.neh.app.repositories;

import com.openmind.neh.app.entities.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

public interface OrderRepository extends JpaRepository<Order, UUID> {
    @Query("SELECT o FROM Order o ORDER BY o.createdAt DESC LIMIT 10")
    List<Order> findRecentOrders();
    @Query("SELECT SUM(o.totalPrice) FROM Order o where o.status = 'DELIVERED'")
    Double calculateTotalRevenue();

    @Query("SELECT SUM(o.totalPrice) FROM Order o WHERE o.createdAt >= :date")
    Double calculateRevenueForPeriod(LocalDateTime date);

    @Query("SELECT COUNT(o) FROM Order o")
    int countTotalOrders();

    @Query("SELECT COUNT(o) FROM Order o WHERE o.createdAt >= :date")
    int countOrdersForPeriod(LocalDateTime date);

    List<Order> getOrderByClient_Id(UUID clientId);

    Page<Order> findAll(Pageable pageable);
}
