package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.service.FundingService;

@Controller
public class HomeController {
	@Autowired
	private FundingService service;
	
	@RequestMapping("/")
	public String index(Model model) {
		model.addAttribute("likesFour", service.selectLikesRankFour());
		model.addAttribute("endFour", service.selectLastestFour());
		model.addAttribute("openFour", service.selectNewestFour());
		
		return "main/mainPage";
	}
}
