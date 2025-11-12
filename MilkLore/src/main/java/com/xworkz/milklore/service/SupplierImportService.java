package com.xworkz.milklore.service;

import java.util.List;

public interface SupplierImportService {
    List<Integer> importSuppliersFromExcel(String filePath);
}
