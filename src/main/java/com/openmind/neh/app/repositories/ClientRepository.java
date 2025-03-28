package com.openmind.neh.app.repositories;

import com.openmind.neh.app.entities.Client;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.UUID;

@Repository
public interface ClientRepository extends JpaRepository<Client, UUID> {
    @Query("SELECT COUNT(c) FROM Client c WHERE c.dateOfCreation >= :date")
    int countNewCustomersForPeriod(LocalDateTime date);

    @Query("SELECT COUNT(c) FROM Client c")
    int countNewCustomers();
}
