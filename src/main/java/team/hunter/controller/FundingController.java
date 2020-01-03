package team.hunter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FundingController {
	
	@RequestMapping("/funding/detail")
	public String fundingDetail() {
		
		return "funding/fundingDetail";
	}

}
