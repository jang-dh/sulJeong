package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.dto.Purchase;
import team.hunter.model.service.PurchaseService;

@Controller
public class PurchaseController {
	
	@Autowired
	private PurchaseService perchaseService;
	
	@RequestMapping("/purchase")
	public String insertPurchase(Purchase purchase) {
		
		System.out.println(3);

		perchaseService.insert(purchase);
		return "fundingDetail";
	}
	
	@RequestMapping("/mypage/fundingHistory")
	public String fundingHistory(Model model) {
		//Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Purchase> list = perchaseService.selectAll();
		model.addAttribute("list", list);
		return "mypage/myFundingHistory";
	}
}
