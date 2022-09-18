package com.example.demo.model.service;

import com.example.demo.model.table.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserProfileRepository extends JpaRepository<UserProfile, Integer> {

    UserProfile findByUserName(String userName);

    UserProfile findByUserNameAndPassWord(String userName, String passWord);

    @Query(value = "select * from user_profile", nativeQuery = true)
    List<UserProfile> findByUserName();

}
