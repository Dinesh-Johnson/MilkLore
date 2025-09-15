package com.xworkz.milklore.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "admin_info")
@NamedQuery(name = "getPasswordByEmail",query = "select e.password from AdminEntity e where e.email =:email")
@NamedQuery(name = "viewAdminByEmail",query = "select e from AdminEntity e where e.email =:email")
@NamedQuery(name = "updateAdminDetails",query = "update AdminEntity e set e.adminName = :adminName, e.mobileNumber = :mobileNumber, " +
        "e.password = :password where e.email = :email")
public class AdminEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "admin_id")
    private Integer adminId;

    @Column(name = "admin_name")
    private String adminName;

    @Column(name = "mobile_number")
    private String mobileNumber;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "confirm_password")
    private String confirmPassword;
}
