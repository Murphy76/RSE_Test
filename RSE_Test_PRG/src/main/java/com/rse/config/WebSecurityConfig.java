package com.rse.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.AuthenticationEntryPoint;

@Configuration
@EnableWebSecurity
@ComponentScan("com.rse.security")
public class WebSecurityConfig  extends WebSecurityConfigurerAdapter {

	@Autowired
	private DataSource dataSource;

	@Autowired
	private AuthenticationEntryPoint authEntryPoint;

//
//	   @Autowired
//	    private CustomAccessDeniedHandler accessDeniedHandler;
//
//	    @Autowired
//	    private RestAuthenticationEntryPoint restAuthenticationEntryPoint;
//
//	    @Autowired
//	    private SavedRequestAwareAuthenticationSuccessHandler mySuccessHandler;
//
//	    private SimpleUrlAuthenticationFailureHandler myFailureHandler = new SimpleUrlAuthenticationFailureHandler();
//
//	    public WebSecurityConfig() {
//	        super();
//	        SecurityContextHolder.setStrategyName(SecurityContextHolder.MODE_INHERITABLETHREADLOCAL);
//	    }
//
//	    @Override
//	    protected void configure(final HttpSecurity http) throws Exception {
//	        http.csrf().disable()
//	            .authorizeRequests()
//	            .and()
//	            .exceptionHandling()
//	            .accessDeniedHandler(accessDeniedHandler)
//	            .authenticationEntryPoint(restAuthenticationEntryPoint)
//	            .and()
//	            .authorizeRequests()
//	            .antMatchers("/*").permitAll()
////	            .antMatchers("/api/customer/**").permitAll()
////	            .antMatchers("/api/foos/**").authenticated()
////	            .antMatchers("/api/async/**").permitAll()
////	            .antMatchers("/api/admin/**").hasRole("ADMIN")
//	            .and()
//	            .formLogin()
//	            .successHandler(mySuccessHandler)
//	            .failureHandler(myFailureHandler)
//	            .and()
//	            .httpBasic()
//	            .and()
//	            .logout();
//	    }
//
	@Bean
	public PasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}

//
//
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder authenticationMgr) throws Exception {
		authenticationMgr.jdbcAuthentication().dataSource(dataSource).passwordEncoder(encoder())
				.usersByUsernameQuery("select username, password, enabled from user where username=?")
				.authoritiesByUsernameQuery(
						"select U.username, R.role from role R inner join USER U on U.ID = R.USER_ID  where U.username=?");
	}

	protected void configure(HttpSecurity http) throws Exception {

http.csrf().disable();
		// All requests send to the Web Server request must be authenticated
//		http.authorizeRequests().antMatchers("/index").permitAll()
//		.and().formLogin().loginPage("/login").permitAll()
//		.and().logout().logoutUrl("/logout")
//		.invalidateHttpSession(true)
//		.deleteCookies("JSESSIONID").permitAll();
//
//		http.formLogin()
//	      .loginPage("/login.html")
//	      .loginProcessingUrl("/notes")
//	      .defaultSuccessUrl("/notes",true)
//	      .failureUrl("/");
http.authorizeRequests().antMatchers("/console").permitAll().antMatchers("/login").permitAll().anyRequest().authenticated();


		// Use AuthenticationEntryPoint to authenticate user/password
		http.httpBasic().authenticationEntryPoint(authEntryPoint);

	}

}
