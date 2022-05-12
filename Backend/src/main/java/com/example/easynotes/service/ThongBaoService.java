package com.example.easynotes.service;

import com.example.easynotes.model.ThongBao;
import com.example.easynotes.model.TaiKhoan;
import com.example.easynotes.service.repository.TaiKhoanRepository;
import com.example.easynotes.service.repository.ThongBaoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ThongBaoService {
    @Autowired
    private ThongBaoRepository thongBaoRepository;

    @Autowired
    private TaiKhoanRepository taiKhoanRepository;

    public List<ThongBao> getAll(){
        return thongBaoRepository.findAll();
    }

    public ThongBao addThongBao(ThongBao thongBao){
        thongBao.setDaXem(false);
        return thongBaoRepository.save(thongBao);
    }

    public ThongBao updateThongBao(Long id, ThongBao thongBao){
        thongBao.setMaThongBao(id);
        return thongBaoRepository.save(thongBao);
    }

    public List<ThongBao> getThongBaoByTaiKhoan(TaiKhoan taiKhoan){
        return thongBaoRepository.findByTaiKhoan(taiKhoan);
    }

    public void addThongBaoByQuyen(String noiDung, String quyen){
        List<TaiKhoan> listTaiKhoan = taiKhoanRepository.getListTaiKhoanByQuyen(quyen);
        for(int i = 0; i < listTaiKhoan.size(); i++){
              ThongBao thongBao = new ThongBao();
              thongBao.setNoiDung(noiDung);
              thongBao.setTaiKhoan(listTaiKhoan.get(i));
              addThongBao(thongBao);
          }
        }
}
