package com.openmind.pure_essence.app.entities;

import com.openmind.pure_essence.security.User.User;
import jakarta.persistence.Entity;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
public class Admin extends User {
}
