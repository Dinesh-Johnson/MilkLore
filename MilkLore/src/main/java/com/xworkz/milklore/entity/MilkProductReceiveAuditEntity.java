package com.xworkz.milklore.entity;


import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "milk_product_receive_audit_info")
public class MilkProductReceiveAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "milk_product_receive_audit_id")
    private Integer milkProductReceiveId;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "created_by")
    private String createdBy;

    @OneToOne
    @JoinColumn(name = "milk_product_receive_id")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private MilkProductReceiveEntity milkProductReceiveEntity;
}
