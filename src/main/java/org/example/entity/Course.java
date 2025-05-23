package org.example.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.antlr.v4.runtime.misc.NotNull;

@Entity
@Data
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long rno;
    private long id;
    @NotNull
    @Column(name="name")
    private String name;
    @Column(nullable = false)
    private String description;
    @Column(nullable = false)
    private String credit;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    @Override
    public String toString(){
        return "Course{rno= "+rno+",id= "+id+",name= "+name+",Desciption= "+description+",Credit= "+credit+",Department Name: "+department+"}";
    }

    public long getRno() {
        return rno;
    }

    public void setRno(long rno) {
        this.rno = rno;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCredit() {
        return credit;
    }

    public void setCredit(String credit) {
        this.credit = credit;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}