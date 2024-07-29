package com.fuhousefinder.configs;

import com.fuhousefinder.dao.*;
import java.security.*;
import java.util.Base64;
import java.util.logging.*;

public class EncodeData {

    public String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    public String hashPassword(String password, String salt) throws NoSuchAlgorithmException {
        String passwordWithSalt = password + salt;
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashedBytes = digest.digest(passwordWithSalt.getBytes());
        return Base64.getEncoder().encodeToString(hashedBytes);
    }

    public boolean checkLogin(String email, String password) {
        IUser dao = new UserDAO();
        String salt = dao.getSaltByEmail(email);
        String hashed_password = dao.getHashed_Password(email);

        if (salt != null && hashed_password != null) {
            try {
                String hash_input_pass = this.hashPassword(password, salt);
                return hashed_password.equals(hash_input_pass);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(EncodeData.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return false;
    }

    public static void main(String[] args) {
        String password = "01020304";
        EncodeData e = new EncodeData();
        // Generate a random salt
        
        System.out.println(e.checkLogin("hanhngulao66@gmail.com", "01020304"));
        /*String salt = "oKhjkpjAZGVCfh83lld5RA==";
        System.out.println(salt);
        Scanner sc = new Scanner(System.in);
        try {
            String hased = e.hashPassword(password, salt);
            System.out.println(hased);
            System.out.println("eg7tCqX/yyJJyNGecVhoxxniicfogmi+YYR1jIHMiWw=");
            System.out.print("Input password: ");
            String inputPass = sc.nextLine();
            String hash_input_pass = e.hashPassword(inputPass, salt);
            System.out.println(hash_input_pass);
        } catch (NoSuchAlgorithmException ex) {
        }*/

    }

}
