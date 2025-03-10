package com.openmind.pure_essence.app.entities;

import com.openmind.pure_essence.security.User.User;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import lombok.*;

import java.time.LocalDate;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Client extends User {
    @OneToMany(mappedBy = "client")
    private List<Order> orders;

}
