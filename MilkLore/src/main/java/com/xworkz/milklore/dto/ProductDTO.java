package com.xworkz.milklore.dto;

import lombok.Data;

@Data
public class ProductDTO {
    private int id;
    private String title;
    private String description;
    private String price;
    private String imagePath;
}
