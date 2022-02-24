package com.example.easynotes.service;

import com.example.easynotes.model.NhaCungCap;
import com.example.easynotes.repository.NhaCungCapRepository;
import com.google.gson.Gson;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.FileReader;
import java.io.IOException;
import java.util.List;

@Service
public class NhaCungCapService {
    @Autowired
    private NhaCungCapRepository repository;

    public List<NhaCungCap> getList(){
        return repository.findAll();
    }

    public NhaCungCap getById(Long id){
        return  repository.findById(id).get();
    }

    public NhaCungCap add(NhaCungCap nhaCungCap){
        return repository.save(nhaCungCap);
    }

    public void deleteById(Long id){
        repository.deleteById(id);
    }

    public NhaCungCap update(NhaCungCap nhaCungCap, Long id){
        if(getById(id) != null){
           nhaCungCap.setMaNhaCungCap(id);
            return  repository.save(nhaCungCap);
        }
        return null;
    }

    public  void initNhaCungCap() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/nha_cung_cap.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                NhaCungCap nhaCungCap = new Gson().fromJson(jsonObject.toString(), NhaCungCap.class);
//                System.out.println(nhaCungCap);
                add(nhaCungCap);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }
}
