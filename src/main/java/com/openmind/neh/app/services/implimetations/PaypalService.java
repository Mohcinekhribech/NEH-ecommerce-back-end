package com.openmind.neh.app.services.implimetations;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.openmind.neh.app.services.interfaces.PaypalServiceInterface;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Base64;
import java.util.Map;

@Service
public class PaypalService implements PaypalServiceInterface {

    @Value("${paypal.client-id}")
    private String clientId;

    @Value("${paypal.client-secret}")
    private String clientSecret;

    @Value("${paypal.api-url}")
    private String paypalApiUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * Fetches PayPal access token using client credentials.
     */
    public String getPayPalAccessToken() throws Exception {
        String auth = Base64.getEncoder().encodeToString((clientId + ":" + clientSecret).getBytes());

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Basic " + auth);
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<String> request = new HttpEntity<>("grant_type=client_credentials", headers);

        ResponseEntity<Map> response = restTemplate.exchange(
                paypalApiUrl + "/v1/oauth2/token",
                HttpMethod.POST,
                request,
                Map.class
        );

        if (response.getBody() != null && response.getBody().containsKey("access_token")) {
            return response.getBody().get("access_token").toString();
        } else {
            throw new Exception("Failed to retrieve PayPal access token");
        }
    }

    /**
     * Verifies a PayPal payment using the order ID.
     */
    public String verifyPayment(String orderId) throws Exception {
        String accessToken = getPayPalAccessToken();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(
                paypalApiUrl + "/v2/checkout/orders/" + orderId,
                HttpMethod.GET,
                entity,
                String.class
        );
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonResponse = objectMapper.readTree(response.getBody());
        return jsonResponse.get("status").asText();

    }
}
