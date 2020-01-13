package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Member;
import team.hunter.model.dto.Purchase;
import team.hunter.model.service.PurchaseSchedule;
import team.hunter.model.service.PurchaseService;
import team.hunter.model.service.StatisticsService;

@Controller
public class PurchaseController {
	
	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private StatisticsService statisticsService;
	
	@Autowired
	private PurchaseSchedule purchaseSchedule;
	
	@RequestMapping(value = "/insertPurchase", method = RequestMethod.POST)
	@ResponseBody
	public int insertPurchase(int fundingCode, int price, int qty, String customerUid, String merchantUid) {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Purchase purchase = new Purchase(0, member.getCode(), fundingCode, price, qty, null, null, null, null, customerUid, merchantUid);
		
		purchaseSchedule.requestSchedulePusrchase(purchase);
		
		statisticsService.updateTotalFundingStackPrice(price);
		statisticsService.updateFundingTotalCount();
		return purchaseService.insert(purchase);
	}
	
	@RequestMapping("/mypage/fundingHistory")
	public ModelAndView fundingHistory() {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
//		System.out.println("이것은 컨트롤러 " + member.getCode() + "이다.");
		List<Purchase> list = purchaseService.myPurchaseList(member.getCode());
//		System.out.println("이것은 컨트롤러 " + list + "이다.");
		
		return new ModelAndView("mypage/myFundingHistory", "list", list);
	}
	
	@RequestMapping("/purchase/delete")
	public String delete(int code) {
		purchaseService.deletePurchaseList(code);
		System.out.println("code : " + code);
		System.out.println("나는 삭제기능 이다.");
		return "redirect:/mypage/fundingHistory";
	}
	
	@RequestMapping("mypage/deliveryCode")
	public String deliveryCodeSend(Purchase purchase) {
		//System.out.println(purchase.getDeliveryNumber()+"트림 전");
		purchase.setDeliveryNumber(purchase.getDeliveryNumber().trim());
		purchase.setCourier(purchase.getCourier().trim());
				purchaseService.deliveryCodeSave(purchase);
				//System.out.println(purchase.getDeliveryNumber()+"트림 후");
		return "redirect:myOpenFunding/"+purchase.getFundingCode();
	}
	
	@RequestMapping("/mypage/deliveryUpdate/{fundingCode}/{memberCode}")
		public String deliveryCodeSelect(@PathVariable int fundingCode, @PathVariable int memberCode, Model model) {
			Member member = purchaseService.deliveryCodeSelect(fundingCode, memberCode);
			model.addAttribute("member", member);
			return "mypage/deliveryUpdateForm";
		}
		
}
