package team.hunter.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.service.FundingService;

@Controller
public class FundingController {
	@Autowired
	private FundingService service;
	
	@RequestMapping("/funding")
	public String funding() {
		
		return "redirect:/funding/category";
	}

	@RequestMapping("/funding/detail")
	public String fundingDetail() {

		return "funding/fundingDetail";
	}

	@RequestMapping("/funding/category")
	public String fundingList(Model model, String order, String where, String val) {
		List<Funding> list = service.selectByCategory(0, order, where, val);
		model.addAttribute("list", list);

		return "funding/fundingList";
	}
	
	@RequestMapping("/funding/category/{categoryCode}")
	public ModelAndView categoryList(@PathVariable int categoryCode, String order, String where, String val) {
		List<Funding> list = service.selectByCategory(categoryCode, order, where, val);
		return new ModelAndView("funding/fundingList", "list", list);
	}
	
}
