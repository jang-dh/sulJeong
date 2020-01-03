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

	@RequestMapping("/funding/detail")
	public String fundingDetail() {

		return "funding/fundingDetail";
	}

	@RequestMapping("/funding")
	public String fundingList(Model model) {
		List<Funding> list = service.selectAll();
		for (Funding f : list)
			System.out.println(f.getEndDate());
		model.addAttribute("list", list);

		return "funding/fundingList";
	}
	
	@RequestMapping("/funding/category/{categoryCode}")
	public ModelAndView categoryList(@PathVariable int categoryCode, HttpServletRequest request) {
		String order = request.getParameter("order");
		String where = request.getParameter("where");
		String val = request.getParameter("val");
		List<Funding> list = service.selectByCategory(categoryCode, order, where, val);
		return new ModelAndView("funding/fundingList", "list", list);
	}
	
}
