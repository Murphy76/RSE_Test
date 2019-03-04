package com.rse.testprg;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@ComponentScan({"com.rse.components.*","com.rse.controller","com.rse.config"})
@EntityScan({"com.rse.domain"})
@EnableJpaRepositories(basePackages = "com.rse.components.repositories")
public class RseTestPrgApplication {

	public static void main(String[] args) {
		SpringApplication.run(RseTestPrgApplication.class, args);
	}

}
