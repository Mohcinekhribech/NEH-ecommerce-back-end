package com.openmind.neh.app.entities;

import com.openmind.neh.security.User.User;
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
