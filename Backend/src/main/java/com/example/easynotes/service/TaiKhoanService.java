package com.example.easynotes.service;

import com.example.easynotes.model.ChiTietHoaDon;
import com.example.easynotes.model.JwtBody;
import com.example.easynotes.model.TaiKhoan;
import com.example.easynotes.service.repository.TaiKhoanRepository;
import com.google.gson.Gson;
import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TaiKhoanService {
    @Autowired
    private TaiKhoanRepository repository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    AuthenticationManager authenticationManager;

    public List<TaiKhoan> getList() {
        return repository.getAll();
    }

    public TaiKhoan getByTenTaiKhoan(String tenTaiKhoan) {
        return repository.findById(tenTaiKhoan).get();
    }

    public TaiKhoan add(TaiKhoan taiKhoan) {
        String password = passwordEncoder.encode(taiKhoan.getMatKhau());
        taiKhoan.setDeleted(false);
        taiKhoan.setMatKhau(password);
        return repository.save(taiKhoan);
    }

    public TaiKhoan doiMatKhauTaiKhoan(String tenTaiKhoan, String matKhauCu, String matKhauMoi) {
        TaiKhoan taiKhoan = getByTenTaiKhoan(tenTaiKhoan);
        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            tenTaiKhoan,
                            matKhauCu
                    )
            );
            taiKhoan.setMatKhau(passwordEncoder.encode(matKhauMoi));
            return update(taiKhoan, taiKhoan.getTenTaiKhoan());
        } catch (Exception e) {
            return null;
        }
    }

    public void deleteByTenTaiKhoan(String tenTaiKhoan) {
        repository.deleteById(tenTaiKhoan);
    }

    public TaiKhoan update(TaiKhoan taiKhoan, String tenTaiKhoan) {
        if (getByTenTaiKhoan(tenTaiKhoan) != null) {
            taiKhoan.setTenTaiKhoan(tenTaiKhoan);
            return repository.save(taiKhoan);
        }
        return null;
    }

    public TaiKhoan getTaiKhoanFromToken(String token) {
        String tenTaiKhoan = getTenTaiKhoanFromToken(token);
        return getByTenTaiKhoan(tenTaiKhoan);
    }


    private String getTenTaiKhoanFromToken(String jwtToken) {
        String[] split_string = jwtToken.split("\\.");
        String base64EncodedHeader = split_string[0];
        String base64EncodedBody = split_string[1];
        String base64EncodedSignature = split_string[2];
        Base64 base64Url = new Base64(true);

//        System.out.println("~~~~~~~~~ JWT Header ~~~~~~~");
//        String header = new String(base64Url.decode(base64EncodedHeader));
//        System.out.println("JWT Header : " + header);

        String body = new String(base64Url.decode(base64EncodedBody));
        JwtBody jwtBody = new Gson().fromJson(body, JwtBody.class);
        return jwtBody.getSub();
    }

}
