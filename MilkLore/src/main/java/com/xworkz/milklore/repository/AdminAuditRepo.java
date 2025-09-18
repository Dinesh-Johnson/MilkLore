package com.xworkz.milklore.repository;

import com.xworkz.milklore.entity.AdminAuditEntity;

public interface AdminAuditRepo {

    boolean save(AdminAuditEntity auditEntity);
}
