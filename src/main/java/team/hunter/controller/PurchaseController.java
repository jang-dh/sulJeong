package team.hunter.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import team.hunter.model.dto.Member;
import team.hunter.model.dto.Paging;
import team.hunter.model.dto.Purchase;
import team.hunter.model.service.FundingService;
import team.hunter.model.service.PurchaseService;
import team.hunter.model.service.StatisticsService;
import team.hunter.util.Constants;

@Controller
public class PurchaseController {

	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private StatisticsService statisticsService;
	@Autowired
	private FundingService fundingService;

	

	@RequestMapping(value = "/insertPurchase", method = RequestMethod.POST)
	@ResponseBody
	public int insertPurchase(int fundingCode, int price, int qty, String customerUid, String merchantUid) {
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Purchase purchase = new Purchase(0, member.getCode(), fundingCode, price, qty, Constants.PURCHASE_BEFORE, null, null, null, customerUid, merchantUid, null);
//		iamportClient = new IamportClient("9641301071926320", "DGvvhuqgbRnvUxwBIwOoU5tDk5AH28ZGPvb7ZCnbtLHnjdZ1JOpETTieYSW11WIRrTYrvmCZ7jnqxnrh");
//		
//		purchaseSchedule.requestSchedulePusrchase(purchase);
//		//결제 시도 시각 설정
//		Funding funding = fundingService.selectByCode(fundingCode);
//		String fundingEndDate = funding.getEndDate();
//		String dates[] = fundingEndDate.split("/");
//		fundingEndDate = String.format("%s-%s-%s 09:00:00 KST", dates[0], dates[1], dates[2]);
//		System.out.println("fundingEndDate :" + fundingEndDate);
//		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z", Locale.KOREA);
//		
//		Date date = null;
//		try {
//			date = dateformat.parse(fundingEndDate);
//			System.out.println("date : " + date);
//			//long unixTime = (long)date.getTime()/1000;
//			ScheduleData data = new ScheduleData(customerUid);
//			ScheduleEntry entry = new ScheduleEntry(merchantUid, date, new BigDecimal(price*qty));
//			data.addSchedule(entry);
//			System.out.println("token : " + iamportClient.getAuth().getResponse().getToken());
//			System.out.println("customerUid : " + customerUid);
//			System.out.println("data.getSchedules().get(0).getMerchantUid() : " + data.getSchedules().get(0).getMerchantUid());
//			System.out.println("data.getSchedules().get(0).getScheduleAt() : " + data.getSchedules().get(0).getScheduleAt());
//			System.out.println("data.getSchedules().get(0).getAmount() : " + data.getSchedules().get(0).getAmount());
//			
//			try {
//				IamportResponse<List<Schedule>> iamportResponse = iamportClient.subscribeSchedule(data);
//				
//				//TODO : 처리 로직
//			} catch (IamportResponseException e) {
//				System.out.println(e.getMessage());
//				
//				switch(e.getHttpStatusCode()) {
//				case 401 :
//					//TODO : 401 Unauthorized 
//					System.out.println(e.getMessage());
//					break;
//				case 404 :
//					//TODO : imp_123412341234 에 해당되는 거래내역이 존재하지 않음
//					System.out.println(e.getMessage());
//				 	break;
//				case 500 :
//					//TODO : 서버 응답 오류
//					System.out.println(e.getMessage());
//					break;
//				}
//			} catch (IOException e) {
//				//서버 연결 실패
//				e.printStackTrace();
//			}
//
//			System.out.println("iamportResponse.getCode() : " + iamportResponse.getCode());
//			System.out.println("iamportResponse.getMessage() "+ iamportResponse.getMessage());
//			System.out.println("iamportResponse.getResponse() : "+ iamportResponse.getResponse().get(0).toString());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		statisticsService.updateTotalFundingStackPrice(price * qty);
		statisticsService.updateFundingTotalCount();

		//cancelPurchase(purchase);
		return purchaseService.insert(purchase);
	}

	@RequestMapping("/mypage/fundingHistory")
	public ModelAndView fundingHistory(@RequestParam(defaultValue = "1") int curPage) {
		ModelAndView mv = new ModelAndView();
		Member member = (Member) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int listCnt = purchaseService.purchaseListCount(member.getCode());
		System.out.println(listCnt);
		Paging paging = new Paging(listCnt, curPage);

		int startIndex = paging.getStartIndex();
		int cntPerPage = paging.getPageSize();
		List<Purchase> list = purchaseService.purchaseList(member.getCode(), startIndex, cntPerPage);

		mv.addObject("list", list);
		mv.addObject("listCnt", listCnt);
		mv.addObject("paging", paging);
		mv.setViewName("mypage/myFundingHistory");
		return mv;

	}

	@RequestMapping("/purchase/update")
	public String update(int code,int price) {
		System.out.println("나는 업데이트를 할 것이다.");
		purchaseService.updatePurchase(code,price);
		System.out.println("나는 업데이트기능 이다.");
		return "redirect:/mypage/fundingHistory";
	}

	@RequestMapping("mypage/deliveryCode")
	public String deliveryCodeSend(Purchase purchase) {
		// System.out.println(purchase.getDeliveryNumber()+"트림 전");
		purchase.setDeliveryNumber(purchase.getDeliveryNumber().trim());
		purchase.setCourier(purchase.getCourier().trim());
		purchaseService.deliveryCodeSave(purchase);
		// System.out.println(purchase.getDeliveryNumber()+"트림 후");
		return "redirect:myOpenFunding/" + purchase.getFundingCode();
	}

	@RequestMapping("/mypage/deliveryUpdate/{fundingCode}/{memberCode}")
	public String deliveryCodeSelect(@PathVariable int fundingCode, @PathVariable int memberCode, Model model) {
		Member member = purchaseService.deliveryCodeSelect(fundingCode, memberCode);
		model.addAttribute("member", member);
		return "mypage/deliveryUpdateForm";
	}

}
