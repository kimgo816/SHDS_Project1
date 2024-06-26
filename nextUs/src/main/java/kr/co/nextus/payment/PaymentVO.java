package kr.co.nextus.payment;

import lombok.Data;

@Data
public class PaymentVO {
    private String storeId;
    private String channelKey;
    private String paymentId;
    private String orderName;
    private int totalAmount;
    private String currency;
    private String payMethod;
    private Customer customer;
    private Coupon coupon;
}

@Data
class Customer {
    private String fullName;
    private String phoneNumber;
    private String email;
}

@Data
class Coupon {
	private int couponNo;
	private int discount;
}