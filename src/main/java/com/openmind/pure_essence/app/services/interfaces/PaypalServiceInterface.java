package com.openmind.pure_essence.app.services.interfaces;

public interface PaypalServiceInterface {
    public String getPayPalAccessToken() throws Exception ;
    public String verifyPayment(String orderId) throws Exception ;
}
