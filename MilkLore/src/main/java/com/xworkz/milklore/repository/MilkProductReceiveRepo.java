package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.MilkProductReceiveEntity;

import java.time.LocalDate;
import java.util.List;

public interface MilkProductReceiveRepo {

    boolean save(MilkProductReceiveEntity milkProductReceiveEntity);
    List<MilkProductReceiveEntity> getAllDetailsByDate(LocalDate collectedDate);
}
