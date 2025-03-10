package com.openmind.pure_essence.app.repositories;

import com.openmind.pure_essence.app.entities.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface TagRepository extends JpaRepository<Tag, UUID> {
}
