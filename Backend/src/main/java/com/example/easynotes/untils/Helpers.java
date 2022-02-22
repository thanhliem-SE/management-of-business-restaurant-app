package com.example.easynotes.untils;

import com.example.easynotes.model.NhaCungCap;
import com.example.easynotes.service.NhaCungCapService;
import com.google.gson.Gson;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.FileReader;
import java.io.IOException;

@Component
public class Helpers {
    @Autowired
    private NhaCungCapService nhaCungCapService;

    public void initNhaCungCap() {
        JSONParser jsonParser = new JSONParser();

        try (FileReader reader = new FileReader("data/nha_cung_cap.json")) {
            //Read JSON file
            Object obj = jsonParser.parse(reader);

            JSONArray jsonArray = (JSONArray) obj;

            jsonArray.forEach(jsonObject -> {
                NhaCungCap nhaCungCap = new Gson().fromJson(jsonObject.toString(), NhaCungCap.class);
                System.out.println(nhaCungCap);
                nhaCungCapService.add(nhaCungCap);
            });

        } catch (IOException | ParseException e) {
            e.printStackTrace();
        }
    }

}
