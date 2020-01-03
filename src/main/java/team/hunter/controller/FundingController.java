package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.dto.Funding;
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
		List<Funding> list =  service.selectAll();
		for(Funding f : list)
			System.out.println(f.getTitle());
		model.addAttribute("list", service.selectAll());
		
		return "funding/fundingList";
	}
}
