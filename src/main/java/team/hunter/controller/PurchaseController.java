package team.hunter.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

//import com.siot.IamportRestClient.IamportClient;
//import com.siot.IamportRestClient.request.ScheduleData;
//import com.siot.IamportRestClient.request.ScheduleEntry;
//import com.siot.IamportRestClient.response.IamportResponse;
//import com.siot.IamportRestClient.response.Schedule;
import com.sun.xml.internal.ws.wsdl.writer.document.Import;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.Purchase;
import team.hunter.model.service.FundingService;
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
	private FundingService fundingService;
	
	//private IamportClient iamportClient;
	
//	@Autowired
//	private PurchaseSchedule purchaseSchedule;
	
	@RequestMapping(value = "/insertPurchase", method = RequestMethod.POST)
	@ResponseBody
	public int insertPurchase(int fundingCode, int price, int qty, String customerUid, String merchantUid) {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Purchase purchase = new Purchase(0, member.getCode(), fundingCode, price, qty, null, null, null, null, customerUid, merchantUid, null);
		//iamportClient = new IamportClient("9641301071926320", "DGvvhuqgbRnvUxwBIwOoU5tDk5AH28ZGPvb7ZCnbtLHnjdZ1JOpETTieYSW11WIRrTYrvmCZ7jnqxnrh");
		
		//purchaseSchedule.requestSchedulePusrchase(purchase);
		//결제 시도 시각 설정
		Funding funding = fundingService.selectByCode(fundingCode);
		String fundingEndDate = funding.getEndDate();
		String dates[] = fundingEndDate.split("/");
		fundingEndDate = String.format("%s-%s-%s 09:00:00 KST", dates[0], dates[1], dates[2]);
		//System.out.println("fundingEndDate :" + fundingEndDate);
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z", Locale.KOREA);
		
		Date date = null;
		try {
			date = dateformat.parse(fundingEndDate);
			System.out.println("date : " + date);
			//long unixTime = (long)date.getTime()/1000;
			//ScheduleData data = new ScheduleData(customerUid);
			//ScheduleEntry entry = new ScheduleEntry(merchantUid, date, new BigDecimal(price*qty));
//			data.addSchedule(entry);
//			System.out.println("token : " + iamportClient.getAuth().getResponse().getToken());
//			System.out.println("customerUid : " + customerUid);
//			System.out.println("data.getSchedules().get(0).getMerchantUid() : " + data.getSchedules().get(0).getMerchantUid());
//			System.out.println("data.getSchedules().get(0).getScheduleAt() : " + data.getSchedules().get(0).getScheduleAt());
//			System.out.println("data.getSchedules().get(0).getAmount() : " + data.getSchedules().get(0).getAmount());
//			
//			IamportResponse<List<Schedule>> iamportResponse = iamportClient.subscribeSchedule(data);
//			System.out.println("iamportResponse.getCode() : " + iamportResponse.getCode());
//			System.out.println("iamportResponse.getMessage() "+ iamportResponse.getMessage());
//			System.out.println("iamportResponse.getResponse() : "+ iamportResponse.getResponse().get(0).toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		statisticsService.updateTotalFundingStackPrice(price);
		statisticsService.updateFundingTotalCount();
		return purchaseService.insert(purchase);
	}
	
	@RequestMapping("/mypage/fundingHistory")
	public ModelAndView fundingHistory() {
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<Purchase> list = purchaseService.listDetail(member.getCode());
		
		for(Purchase p : list) {
			System.out.println("택배회사 : " + p.getCourier());
			System.out.println("송장번호 : " + p.getDeliveryNumber());
			System.out.println("구매일자 : " + p.getPurchaseDate());
			System.out.println("금액 : " + p.getPrice());
			System.out.println("구매상태 :  " + p.getPurchaseState());
			System.out.println("후원상태 : " + p.getFunding().getFundingState());
		}
		System.out.println();
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
