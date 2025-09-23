package com.xworkz.milklore.entity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;

@Slf4j
@Data
@Entity
@Table(name = "supplier_d")
@NamedQuery(name = "getAllSuppliers",query = "select e from SupplierEntity e where e.isActive=true")
@NamedQuery(name = "checkEmail",query = "select e from SupplierEntity e where e.email=:email and e.isActive=true")
@NamedQuery(name = "checkPhoneNumber",query = "select e from SupplierEntity e where e.phoneNumber=:phoneNumber and e.isActive=true")
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
}