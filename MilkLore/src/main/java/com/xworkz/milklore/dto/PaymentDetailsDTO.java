package com.xworkz.milklore.dto;

import com.xworkz.milklore.entity.AdminEntity;
import com.xworkz.milklore.entity.SupplierEntity;
import lombok.Data;

import java.time.LocalDate;

@Data
public class PaymentDetailsDTO {

    private Integer id;
    private SupplierEntity supplier;
    private AdminEntity admin;
    private Double totalAmount;
    private LocalDate periodStart;
    private LocalDate periodEnd;
    private LocalDate paymentDate;
    private String paymentStatus;

}