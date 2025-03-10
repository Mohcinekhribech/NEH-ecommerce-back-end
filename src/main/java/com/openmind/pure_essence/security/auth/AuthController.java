package com.openmind.pure_essence.security.auth;

import com.openmind.pure_essence.app.dtos.request.AdminDtoRequest;
import com.openmind.pure_essence.app.dtos.request.ClientDtoRequest;
import com.openmind.pure_essence.shareable.ResponseMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthenticationService service;
    private final ResponseMessage responseMessage;

    @PostMapping("/register-client")
    public ResponseEntity<AuthenticationResponse> clientRegister(
            @RequestBody ClientDtoRequest request
    ) {
        return ResponseEntity.ok(service.clientRegister(request));
    }
    @PostMapping("/register-admin")
    public ResponseEntity<AuthenticationResponse> adminRegister(
            @RequestBody AdminDtoRequest request
    ) {
        return ResponseEntity.ok(service.adminRegister(request));
    }
    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate(
            @RequestBody AuthenticationRequest request
    ) {
        return ResponseEntity.ok(service.authenticate(request));
    }

    @PostMapping("/refresh-token")
    public void refreshToken(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {
        service.refreshToken(request, response);
    }

    @PostMapping("/logout")
    public ResponseEntity<ResponseMessage> logout(HttpServletRequest request, HttpServletResponse response) {
        // Invalidate JWT token by removing it from client-side storage
        service.logout(request,response);
        responseMessage.setMessage("Logout successful");
        return ResponseEntity.ok(responseMessage);
    }

}