package com.example.easynotes.config;

import com.example.easynotes.jwt.JwtAuthenticationFilter;
import com.example.easynotes.service.TaiKhoanService;
import com.example.easynotes.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.http.HttpServletResponse;

@Configuration
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    UserService userService;

    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter() {
        return new JwtAuthenticationFilter();
    }

    @Bean(BeanIds.AUTHENTICATION_MANAGER)
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        // Get AuthenticationManager bean
        return super.authenticationManagerBean();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // Password encoder, để Spring Security sử dụng mã hóa mật khẩu người dùng
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth)
            throws Exception {
        auth.userDetailsService(userService) // Cung cáp userservice cho spring security
                .passwordEncoder(passwordEncoder()); // cung cấp password encoder
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        // Enable CORS and disable CSRF
        http = http.cors().and().csrf().disable();

        // Set session management to stateless
        http = http
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and();

        // Set unauthorized requests exception handler
        http = http
                .exceptionHandling()
                .authenticationEntryPoint(
                        (request, response, ex) -> {
                            response.sendError(
                                    HttpServletResponse.SC_UNAUTHORIZED,
                                    ex.getMessage()
                            );
                        }
                )
                .and();

                // Our public endpoints
        http.authorizeRequests().antMatchers(HttpMethod.POST,"/api/login**").permitAll()
                .antMatchers(HttpMethod.POST,"/api/getbytoken**").permitAll()
                .antMatchers(HttpMethod.GET, "/").permitAll()
                // permission for thuc pham api
                .antMatchers(HttpMethod.GET, "/api/thucpham/**").permitAll()
                .antMatchers(HttpMethod.POST, "/api/thucpham/").hasAnyRole("ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.DELETE, "/api/thucpham/**").hasAnyRole("ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.PUT, "/api/thucpham/**").hasAnyRole("ROLE_QUANLY", "ROLE_ADMIN")
                // permission for chi tiet thuc pham
                .antMatchers(HttpMethod.GET, "/api/chitietthucpham/**").permitAll()
                .antMatchers(HttpMethod.POST, "/api/chitietthucpham/").hasAnyRole("ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.DELETE, "/api/chitietthucpham/**").hasAnyRole("ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.PUT, "/api/chitietthucpham/**").hasAnyRole("ROLE_QUANLY", "ROLE_ADMIN")
                // permission for hoa don
                .antMatchers(HttpMethod.DELETE, "/api/hoadon/**").hasAnyRole( "ROLE_NHANVIEN","ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.PUT, "/api/hoadon/**").hasAnyRole( "ROLE_NHANVIEN","ROLE_QUANLY", "ROLE_ADMIN")
                // permission for chi tiet hoa don
                .antMatchers(HttpMethod.DELETE, "/api/chitiethoadon/**").hasAnyRole( "ROLE_NHANVIEN","ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.PUT, "/api/chitiethoadon/**").hasAnyRole( "ROLE_NHANVIEN","ROLE_QUANLY", "ROLE_ADMIN")
                // permission for thanh toan
                .antMatchers(HttpMethod.DELETE, "/api/thanhtoan/**").hasAnyRole( "ROLE_NHANVIEN","ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.PUT, "/api/thanhtoan/**").hasAnyRole( "ROLE_NHANVIEN","QUANLY", "ROLE_ADMIN")
                // permission for nhan vien
                .antMatchers(HttpMethod.DELETE, "/api/nhanvien/**").hasAnyRole( "ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.PUT, "/api/nhanvien/**").hasAnyRole( "ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.POST, "/api/nhanvien/").hasAnyRole( "ROLE_QUANLY", "ROLE_ADMIN")
                // permission for khach hang
                .antMatchers(HttpMethod.POST, "/api/khachhang/").permitAll()
                .antMatchers(HttpMethod.GET, "/api/khachhang/").hasAnyRole( "ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.DELETE, "/api/khachhang/**").hasAnyRole( "ROLE_QUANLY", "ROLE_ADMIN")
                .antMatchers(HttpMethod.PUT, "/api/khachhang/**").hasAnyRole( "ROLE_KHACHHANG","ROLE_QUANLY", "ROLE_ADMIN")
                // permission tai khoan
                .antMatchers(HttpMethod.POST, "/api/taikhoan/").permitAll()
                .antMatchers(HttpMethod.GET, "api/taikhoan/").hasAnyRole("ROLE_ADMIN")
                .antMatchers(HttpMethod.DELETE, "api/taikhoan/**").hasAnyRole( "ROLE_ADMIN")
                // permission nha cung cap
                .antMatchers("/api/nhacungcap/**").hasAnyRole( "ROLE_NHANVIEN","ROLE_QUANLY", "ROLE_ADMIN")
                //permission nguyen lieu
                .antMatchers("/api/nguyenlieu/**").hasAnyRole( "ROLE_NHANVIEN","ROLE_QUANLY", "ROLE_ADMIN")
                // permission lieu luong
                .antMatchers("/api/lieuluong/**").hasAnyRole( "ROLE_NHANVIEN","ROLE_QUANLY", "ROLE_ADMIN")
                // Out private endpoint
                .anyRequest().authenticated();


        // Thêm một lớp Filter kiểm tra jwt
        http.addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);
    }
}