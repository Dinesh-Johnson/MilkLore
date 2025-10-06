package com.xworkz.milklore.entity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;
import java.util.List;

@Slf4j
@Data
@Entity
@Table(name = "supplier_d")
@NamedQuery(name = "checkEmail",query = "select e from SupplierEntity e where e.email=:email and e.isActive=true")
@NamedQuery(name = "checkPhoneNumber",query = "select e from SupplierEntity e where e.phoneNumber=:phoneNumber and e.isActive=true")
@NamedQuery(name="getSuppliersCount",query = "select count(a) from SupplierEntity a where a.isActive=true")
@NamedQuery(name = "getAllSuppliers",query = "select a from SupplierEntity a where a.isActive=true order by a.supplierId DESC")
@NamedQuery(name = "searchSupplierEmailNameMobile",
        query = "SELECT a FROM SupplierEntity a " +
                "WHERE (LOWER(a.firstName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) " +
                "OR LOWER(a.lastName) LIKE LOWER(CONCAT('%', :searchTerm, '%')) " +
                "OR LOWER(a.email) LIKE LOWER(CONCAT('%', :searchTerm, '%')) " +
                "OR a.phoneNumber LIKE CONCAT('%', :searchTerm, '%')) " +
                "AND a.isActive = true")

public class SupplierEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "supplier_id")
    private Integer supplierId;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name ="email")
    private String email;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "address")
    private String address;

    @Column(name = "type_of_milk")
    private String typeOfMilk;

    @OneToOne(mappedBy = "supplierEntity",cascade = CascadeType.ALL,fetch = FetchType.LAZY,orphanRemoval=true)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private SupplierAuditEntity supplierAuditEntity;

    @Column(name = "is_active")
    private Boolean isActive;

    @OneToMany(mappedBy = "supplier")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<MilkProductReceiveEntity> milkProductReceiveList;
}