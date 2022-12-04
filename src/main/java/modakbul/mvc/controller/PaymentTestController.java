package modakbul.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PaymentTestController {

	@RequestMapping("/payment/payment")
	public void pay() {
	//	System.out.println(result);
	}
	
	@RequestMapping("/ajaxTest")
	@ResponseBody
	public String ajaxTest( ) {
		
	
		return "안녕";
	}
		

	@RequestMapping("/payment/success")
	//@ResponseBody
	public void aa () {
		System.out.println("찍히니?");
	}
}
