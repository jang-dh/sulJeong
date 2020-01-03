package team.hunter.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.dto.Purchase;
import team.hunter.model.service.PurchaseService;

@Controller
public class PurchaseController {
	
	@Autowired
	private PurchaseService service;
	
	@RequestMapping("/funding/purchase")
	public String insertPurchase(Purchase purchase) {
		
		//System.out.println(1);

		service.insertPerchase(purchase);
		return "fundingDetail";
	}
	
}
