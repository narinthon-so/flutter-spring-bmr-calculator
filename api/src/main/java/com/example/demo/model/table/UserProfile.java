package com.example.demo.model.table;

import lombok.Data;
import lombok.ToString;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Data
@ToString
@Entity(name = "user_profile")
public class UserProfile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull(message = "user name can not null")
    @Column(name = "user_name")
    private String userName;

    @NotNull(message = "pass word can not null")
    @Column(name = "pass_word")
    private String passWord;

}
