package com.openmind.neh.security.auth;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.openmind.neh.app.dtos.request.AdminDtoRequest;
import com.openmind.neh.app.dtos.request.ClientDtoRequest;
import com.openmind.neh.app.entities.Admin;
import com.openmind.neh.app.entities.Client;
import com.openmind.neh.app.repositories.AdminRepository;
import com.openmind.neh.app.repositories.ClientRepository;
import com.openmind.neh.security.User.DTOs.UserDTO;
import com.openmind.neh.security.User.Role;
import com.openmind.neh.security.User.User;
import com.openmind.neh.security.User.UserRepository;
import com.openmind.neh.security.jwt.JwtService;
import com.openmind.neh.security.token.Token;
import com.openmind.neh.security.token.TokenRepository;
import com.openmind.neh.security.token.TokenType;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
    private final UserRepository repository;
    private final AdminRepository adminRepository;
    private final ClientRepository clientRepository;
    private final TokenRepository tokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;
    private final ModelMapper modelMapper;

    public AuthenticationResponse adminRegister(AdminDtoRequest request) {
        Admin admin = Admin.builder()
                .build();
        admin.setFirstName(request.getFirstName());
        admin.setLastName(request.getLastName());
        admin.setEmail(request.getEmail());
        admin.setProfilePic(request.getProfilePic());
        admin.setAgeRange(request.getAgeRange());
        admin.setPassword(passwordEncoder.encode(request.getPassword()));
        admin.setPhone(request.getPhone());
        admin.setAddress(request.getAddress());
        admin.setCity(request.getCity());
        admin.setZipCode(request.getZipCode());
        admin.setRole(Role.Admin);
        admin.setCountry(request.getCountry());

        User savedUser = adminRepository.save(admin);
        var jwtToken = jwtService.generateToken(admin);
        var refreshToken = jwtService.generateRefreshToken(admin);
        saveUserToken(savedUser, jwtToken);
        return AuthenticationResponse.builder()
                .accessToken(jwtToken)
                .refreshToken(refreshToken)
                .user(modelMapper.map(savedUser, UserDTO.class))
                .build();
    }

    public AuthenticationResponse clientRegister(ClientDtoRequest request) {
        Client client = Client.builder()
                .build();
        client.setFirstName(request.getFirstName());
        client.setLastName(request.getLastName());
        client.setEmail(request.getEmail());
        client.setProfilePic(request.getProfilePic());
        client.setAgeRange(request.getAgeRange());
        client.setPhone(request.getPhone());
        client.setAddress(request.getAddress());
        client.setCity(request.getCity());
        client.setZipCode(request.getZipCode());
        client.setCountry(request.getCountry());
        client.setRole(Role.Client);
        client.setPassword(passwordEncoder.encode(request.getPassword()));

        var savedUser = clientRepository.save(client);
        var jwtToken = jwtService.generateToken(client);
        var refreshToken = jwtService.generateRefreshToken(client);
        saveUserToken(savedUser, jwtToken);
        return AuthenticationResponse.builder()
                .accessToken(jwtToken)
                .refreshToken(refreshToken)
                .user(modelMapper.map(savedUser, UserDTO.class))
                .build();
    }

    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );
        var user = repository.findByEmail(request.getEmail())
                .orElseThrow();
        var jwtToken = jwtService.generateToken(user);
        var refreshToken = jwtService.generateRefreshToken(user);
        revokeAllUserTokens(user);
        saveUserToken(user, jwtToken);
        return AuthenticationResponse.builder()
                .accessToken(jwtToken)
                .user(modelMapper.map(user, UserDTO.class))
                .refreshToken(refreshToken)
                .build();
    }

    private void saveUserToken(User user, String jwtToken) {
        var token = Token.builder()
                .user(user)
                .token(jwtToken)
                .tokenType(TokenType.BEARER)
                .expired(false)
                .revoked(false)
                .build();
        tokenRepository.save(token);
    }

    private void revokeAllUserTokens(User user) {
        var validUserTokens = tokenRepository.findAllValidTokenByUser(user.getId());
        if (validUserTokens.isEmpty())
            return;
        validUserTokens.forEach(token -> {
            token.setExpired(true);
            token.setRevoked(true);
        });
        tokenRepository.saveAll(validUserTokens);
    }

    public void refreshToken(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {
        final String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Missing or invalid refresh token\"}");
            return;
        }

        final String refreshToken = authHeader.substring(7);
        final String userEmail = jwtService.extractUsername(refreshToken);

        if (userEmail == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Invalid refresh token\"}");
            return;
        }

        try {
            var user = repository.findByEmail(userEmail)
                    .orElseThrow(() -> new UsernameNotFoundException("User not found"));

            if (jwtService.isTokenValid(refreshToken, user)) {
                var accessToken = jwtService.generateToken(user);
                revokeAllUserTokens(user);
                saveUserToken(user, accessToken);

                var authResponse = AuthenticationResponse.builder()
                        .accessToken(accessToken)
                        .refreshToken(refreshToken)
                        .build();

                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_OK);
                new ObjectMapper().writeValue(response.getOutputStream(), authResponse);
            } else {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\": \"Invalid refresh token\"}");
            }
        } catch (UsernameNotFoundException e) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"User not found\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Something went wrong\"}");
        }
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) {
        final String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String accessToken = authHeader.substring(7);
            String userEmail = jwtService.extractUsername(accessToken);
            if (userEmail != null) {
                User user = repository.findByEmail(userEmail).orElse(null);
                if (user != null) {
                    tokenRepository.deleteAllByUser(user);
                    response.setStatus(HttpServletResponse.SC_OK);
                    return;
                }
            }
        }
        // If no token found or user not found, return an error response
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    }
}