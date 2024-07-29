/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.entity;

/**
 *
 * @author phung
 */
public class Response {
     String status;
        String message;

    public Response(String status, String message) {
            this.status = status;
            this.message = message;
        }
}
