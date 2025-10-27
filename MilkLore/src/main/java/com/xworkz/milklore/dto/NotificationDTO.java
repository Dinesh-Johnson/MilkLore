package com.xworkz.milklore.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class NotificationDTO {
    private Integer id;
    private Integer adminID;
    private String message;
    private Boolean isRead;
    private String link; // URL to supplier/payment details page
    private LocalDateTime createdAt;

}
