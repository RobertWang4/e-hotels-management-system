package com.ehotels;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
public class EhotelsApplication {
    public static void main(String[] args) {
        SpringApplication.run(EhotelsApplication.class, args);
    }
}
