package modakbul.mvc.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import modakbul.mvc.service.AdminService;

@Controller

public class PaymentTestController {
	@Autowired
	private AdminService adminSer; 
	

	@RequestMapping("/payment/payment")
	public void pay() {
	//	System.out.println(result);
	}
	
	@RequestMapping("/ajaxTest")
	@ResponseBody
	public int ajaxTest(@RequestBody Map<String, Object> result) {
		for (String m:result.keySet()) {
			 System.out.println("key:"+m+",value:"+result.get(m));
		}
		//adminSer.advertisementInsert(new Advertisement(66L, "신청대기", "asd"));
		//이거 호출 하는것 빼고 연결함,, 

		
		System.out.println("123123");
		return 1;
	}
		

	@RequestMapping("/payment/success")
	//@ResponseBody
	public void aa () {
		System.out.println("찍히니?");
	}
}
