package com.openmind.neh.security;

import com.openmind.neh.security.User.Role;
import com.openmind.neh.security.jwt.JwtAuthenticationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@EnableMethodSecurity
public class SecurityConfiguration {

    private static final String[] WHITE_LIST_URL = {"/**"
            };
    private final JwtAuthenticationFilter jwtAuthFilter;
    private final AuthenticationProvider authenticationProvider;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.cors(Customizer.withDefaults())
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(req ->
                        req.requestMatchers(HttpMethod.GET, "/**") // Allow all GET requests
                                .permitAll()
                                .requestMatchers(HttpMethod.POST, "/api/auth/**", "/api/upload/images") // Allow these specific POST requests for all users
                                .permitAll()
                                .requestMatchers(HttpMethod.POST, "/api/orders", "/api/orders/payment-status") // Allow POST for creating orders
                                .hasAnyAuthority(Role.Client.name(), Role.Admin.name())
                                .requestMatchers(HttpMethod.POST, "/api/category","/api/product","/api/product-media","/api/tags") // Allow POST requests only for admin
                                .hasAuthority(Role.Admin.name())
                                .requestMatchers(HttpMethod.PUT, "/**") // Allow PUT requests only for admin
                                .hasAuthority(Role.Admin.name())
                                .requestMatchers(HttpMethod.DELETE, "/**") // Allow DELETE requests only for admin
                                .hasAuthority(Role.Admin.name())
                                .anyRequest() // Any other request needs to be authenticated
                                .authenticated()
                )
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authenticationProvider(authenticationProvider)
                .addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class)
        ;

        return http.build();
    }


}
