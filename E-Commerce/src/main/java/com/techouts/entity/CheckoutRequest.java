package com.techouts.entity;

import jakarta.persistence.Column;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheckoutRequest {
    @Column(length = 100)
    private String address;
    private String city;
    private String state;
    private String pincode;
    private String status;
    private String paymentType;
}
