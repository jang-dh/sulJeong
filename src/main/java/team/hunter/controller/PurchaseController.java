package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
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

		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Purchase purchase = new Purchase(0, member.getCode(), fundingCode, price, qty, null, null, null, null);
		return purchaseService.insert(purchase);
	}
	
	@RequestMapping("/mypage/fundingHistory")
	public ModelAndView fundingHistory() {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		System.out.println("이것은 컨트롤러 " + member.getCode() + "이다.");
		List<Purchase> list = purchaseService.myPurchaseList(member.getCode());
		System.out.println("이것은 컨트롤러 " + list + "이다.");
		
		return new ModelAndView("mypage/myFundingHistory", "list", list);
	}
	
	@RequestMapping("/mypage/delete")
	public String delete(int code) {
		purchaseService.deletePurchaseList(code);
		return "redirect:mypage/fundingHistory";
	}
	
	@RequestMapping("mypage/deliveryCode")
	public String deliveryCodeSend(Purchase purchase, Model model) {
				purchaseService.deliveryCodeSave(purchase);
		return "redirect:myOpenFunding/"+purchase.getFundingCode();
	}
}
