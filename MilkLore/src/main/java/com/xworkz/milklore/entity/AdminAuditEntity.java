package com.xworkz.milklore.entity;


import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "admin_audit_info")
public class AdminAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "audit_id")
    private Integer auditId;

    @Column(name = "audit_name")
    private String auditName;


    @Column(name = "log_in_time")
    private LocalDateTime loggedInTime;

    @OneToOne
    @JoinColumn(name = "admin_id")
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private AdminEntity adminEntity;
}
