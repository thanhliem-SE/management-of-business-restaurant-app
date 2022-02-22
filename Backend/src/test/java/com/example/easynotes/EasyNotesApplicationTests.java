package com.example.easynotes;

import com.example.easynotes.service.NhaCungCapService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class EasyNotesApplicationTests {
	@Autowired
	NhaCungCapService nhaCungCapService;


	@Test
	public void contextLoads() {
		nhaCungCapService.initNhaCungCap();
	}

}
