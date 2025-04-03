package com.openmind.neh.config;

import com.openmind.neh.app.dtos.request.AdminDtoRequest;
import com.openmind.neh.app.entities.enums.AgeRange;
import com.openmind.neh.security.User.DTOs.UserRequest;
import com.openmind.neh.security.User.Role;
import com.openmind.neh.security.User.UserRepository;
import com.openmind.neh.security.auth.AuthenticationResponse;
import com.openmind.neh.security.auth.AuthenticationService;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AdminSeeder implements CommandLineRunner {

    private final AuthenticationService adminService;
    private final ModelMapper modelMapper;
    private final UserRepository adminRepository;

    @Override
    public void run(String... args) throws Exception {
        // Check if the admin already exists
        if (adminRepository.findByEmail("contact@neh-cosmetics.com").isEmpty()) {
            // Prepare AdminDtoRequest for seeding
            AdminDtoRequest request = AdminDtoRequest.builder()
                    .firstName("Admin")
                    .lastName("User")
                    .email("contact@neh-cosmetics.com")
                    .profilePic("pr")  // Placeholder URL for the profile pic
                    .ageRange(AgeRange.AGE_18_24)              // Example age range
                    .password("neh-openmind@2025")      // Secure password should be handled properly
                    .build();

            // Call the service to register the admin
            AuthenticationResponse response = adminService.adminRegister(request);

            // Output the result
            System.out.println("Admin created: " + response.getUser().getEmail());
        } else {
            // If the admin already exists, inform
            System.out.println("Admin already exists!");
        }
    }
}
