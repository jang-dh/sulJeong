package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.Purchase;
import team.hunter.model.service.PurchaseService;

@Controller
public class PurchaseController {
	
	@Autowired
	private PurchaseService purchaseService;
	
	@RequestMapping(value = "/insertPurchase", method = RequestMethod.POST)
	@ResponseBody
	public int insertPurchase(int fundingCode, int price, int qty) {

		System.out.println("fundingCode : " + fundingCode);
		System.out.println("price : " + price);
		System.out.println("qty : " + qty);

		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Purchase purchase = new Purchase(0, member.getCode(), fundingCode, price, qty, null, null, null, null);
		return purchaseService.insert(purchase);
	}
	
	@RequestMapping("/mypage/fundingHistory")
	public ModelAndView fundingHistory() {
		//Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Purchase> list = purchaseService.selectAll();
		ModelAndView mv = new ModelAndView();
		mv.addObject("list", list);
		mv.setViewName("mypage/myFundingHistory");
		return mv;
	}
}
