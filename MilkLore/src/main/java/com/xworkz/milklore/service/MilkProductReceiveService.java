package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.MilkProductReceiveDTO;

import java.time.LocalDate;
import java.util.List;

public interface MilkProductReceiveService {

    boolean save(MilkProductReceiveDTO milkProductReceiveDTO, String email);
    List<MilkProductReceiveDTO > getAllDetailsByDate(LocalDate collectedDate);
}
