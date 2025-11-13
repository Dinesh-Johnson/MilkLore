package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.SupplierDTO;

import java.util.List;

public interface SupplierImportService {
    List<SupplierDTO> importSuppliersFromExcel(String filePath, String email);
}
