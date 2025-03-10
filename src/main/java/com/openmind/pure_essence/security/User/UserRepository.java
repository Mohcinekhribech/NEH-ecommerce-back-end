package com.openmind.pure_essence.security.User;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {

    Optional<User> findByEmail(String email);
    @Query("SELECT COUNT(u) FROM User u WHERE u.dateOfCreation >= :date")
    int countNewCustomersForPeriod(LocalDateTime date);

    @Query("SELECT COUNT(u) FROM User u")
    int countNewCustomers();



}
