package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.ProductPriceEntity;

import java.util.List;

public interface ProductPriceRepo {

    boolean saveProduct(ProductPriceEntity entity);
    List<ProductPriceEntity> getAllDetails();
    boolean updateProduct(ProductPriceEntity productPriceEntity);
    boolean deleteProduct(Integer productId);
}