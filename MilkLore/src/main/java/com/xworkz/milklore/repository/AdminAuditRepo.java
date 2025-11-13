package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.AdminAuditEntity;

import java.util.Optional;

public interface AdminAuditRepo {

    boolean save(AdminAuditEntity auditEntity);
    Optional<AdminAuditEntity> findActiveSession(Integer adminId);
}
