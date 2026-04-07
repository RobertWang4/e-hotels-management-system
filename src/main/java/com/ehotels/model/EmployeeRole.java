package com.ehotels.model;

import jakarta.persistence.*;

@Entity
@Table(name = "employee_role")
public class EmployeeRole {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "role_id")
    private Integer roleId;

    @Column(nullable = false)
    private String name;

    public Integer getRoleId() { return roleId; }
    public String getName() { return name; }

    public void setRoleId(Integer roleId) { this.roleId = roleId; }
    public void setName(String name) { this.name = name; }
}
