package org.zerock.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import org.zerock.security.CustomLoginSuccessHandler;
import org.zerock.security.CustomAccessDeniedHandler;
import org.zerock.security.CustomNoOpPasswordEncoder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.zerock.security.CustomUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new CustomNoOpPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return new CustomUserDetailsService();
    }

    @Bean
    public CustomLoginSuccessHandler loginSuccessHandler() {
        return new CustomLoginSuccessHandler();
    }

    @Bean
    public CustomAccessDeniedHandler accessDeniedHandler() {
        return new CustomAccessDeniedHandler();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http.authorizeRequests()
            .antMatchers("/", "/member/join", "/customLogin", "/resources/**").permitAll()
            .antMatchers("/mypage/**").authenticated()
            .antMatchers("/word/**").authenticated()
            .anyRequest().permitAll();

        http.formLogin()
            .loginPage("/customLogin")
            .loginProcessingUrl("/login")
            .successHandler(loginSuccessHandler())
            .permitAll();

        http.logout()
            .logoutUrl("/customLogout")
            .logoutSuccessUrl("/customLogin?logout=true")
            .permitAll();

        http.exceptionHandling()
            .accessDeniedHandler(accessDeniedHandler());

        http.csrf().disable();

        return http.build();
    }
}

