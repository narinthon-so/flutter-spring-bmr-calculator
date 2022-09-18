package com.example.demo.controller;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class APIResponse {
    private int status;
    private String message;
    private Object data;
}
