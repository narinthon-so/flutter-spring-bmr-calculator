package com.example.demo.controller;

import com.example.demo.model.service.UserProfileRepository;
import com.example.demo.model.table.UserProfile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserProfileRepository userProfileRepository;

    @PostMapping("/save")
    public Object save(UserProfile userProfile, @RequestParam String userName, @RequestParam String passWord) {
        APIResponse response = new APIResponse();
        UserProfile dbUser = userProfileRepository.findByUserName(userName);
        if (dbUser == null) {
            userProfileRepository.save(userProfile);
            String strUserName = userProfile.getUserName();
            response.setStatus(0);
            response.setMessage("saved...");
            response.setData(strUserName);
        } else {
            response.setStatus(1);
            response.setMessage("user already exist...");
        }
        return response;
    }

    @PostMapping("/login")
    public Object login(@RequestParam String userName, @RequestParam String passWord){
        APIResponse response = new APIResponse();
        UserProfile db = userProfileRepository.findByUserNameAndPassWord(userName, passWord);
        if(db == null){
            response.setStatus(1);
            response.setMessage("Invalid username or password");
        }else {
            response.setStatus(0);
            response.setMessage("login success");
        }

        return response;
    }

    @PostMapping("/list")
    public Object list() {
        APIResponse res = new APIResponse();
        res.setData(userProfileRepository.findByUserName());
        return res;
    }
}
