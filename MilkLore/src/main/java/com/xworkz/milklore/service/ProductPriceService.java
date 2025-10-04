package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.ProductPriceDTO;

import java.util.List;

public interface ProductPriceService {

    boolean saveProduct(ProductPriceDTO productPriceDTO, String adminEmail);
    List<ProductPriceDTO> getAllDetails();
    boolean updateProduct(ProductPriceDTO productPriceDTO,String adminEmail);
    boolean deleteProduct(Integer productId);
}