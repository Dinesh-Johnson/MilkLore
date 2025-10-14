package com.xworkz.milklore.dto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;
import java.time.LocalDate;

import lombok.Data;

@Data
public class MilkProductReceiveDTO {

    private Integer milkProductReceiveId;
    private SupplierDTO supplier;
    private AdminDTO admin;

    @NotBlank
    private String phoneNumber;

    @NotBlank
    private String typeOfMilk;

    @NotNull
    @Positive
    private Double price;

    @NotNull
    @Positive
    private Float quantity;

    @NotNull
    @Positive
    private Double totalAmount;

    @NotNull
    private LocalDate collectedDate=LocalDate.now();
}
