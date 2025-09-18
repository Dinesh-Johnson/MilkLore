package com.xworkz.milklore.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;

@Data
@Entity
@Table(name = "admin_info")
@NamedQuery(name = "viewAdminByEmail",query = "select e from AdminEntity e where e.email =:email")
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

    @Column(name = "profile_path")
    private String profilePath;

    @Column(name = "blocked_status")
    private Boolean blockedStatus;


    @OneToOne(cascade = CascadeType.ALL,mappedBy = "adminEntity")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private AdminAuditEntity audit;

}
