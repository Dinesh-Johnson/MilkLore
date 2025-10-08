package com.xworkz.milklore.entity;



import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDate;

@Data
@Entity
@Table(name = "milk_product_receive_details")
@NamedQuery(name = "getAllDetailsByDate",
        query = "select e from MilkProductReceiveEntity e JOIN FETCH e.supplier JOIN FETCH e.admin where e.collectedDate = :collectedDate")
public class MilkProductReceiveEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "milk_product_receive_id")
    private Integer milkProductReceiveId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "supplier_id",nullable = false)
    private SupplierEntity supplier;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "admin_id",nullable = false)
    private AdminEntity admin;

    @Column(name = "type_of_milk")
    private String typeOfMilk;

    @Column(name = "price")
    private Double price;

    @Column(name = "quantity")
    private Float quantity;

    @Column(name = "total_amount")
    private Double totalAmount;

    @Column(name = "collected_date")
    private LocalDate collectedDate;

    @OneToOne(cascade = CascadeType.ALL,mappedBy = "milkProductReceiveEntity")
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private MilkProductReceiveAuditEntity milkProductReceiveAuditEntity;

}
