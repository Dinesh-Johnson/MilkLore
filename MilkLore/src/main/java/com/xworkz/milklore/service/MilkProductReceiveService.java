package com.xworkz.milklore.service;

import com.xworkz.milklore.dto.MilkProductReceiveDTO;

public interface MilkProductReceiveService {

    public boolean save(MilkProductReceiveDTO milkProductReceiveDTO, String email);
}
