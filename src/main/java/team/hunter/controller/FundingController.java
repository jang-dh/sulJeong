package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.service.FundingService;

@Controller
public class FundingController {
	@Autowired
	private FundingService service;
	
	@RequestMapping("/funding/detail")
	public String fundingDetail() {

		return "funding/fundingDetail";
	}

	@RequestMapping("/funding")
	public String fundingList(Model model) {
		//model.addAttribute("list", service.selectAll());
		return "funding/fundingList";
	}
}
