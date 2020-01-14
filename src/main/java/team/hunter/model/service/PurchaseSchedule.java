package team.hunter.model.service;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Purchase;

//@Service
public class PurchaseSchedule {
	RestTemplate restTemplate = new RestTemplate();
	private final static Gson gson = new Gson();

	@Autowired
	FundingService fundingService;

	// 결제 서비스에 대한 토큰 얻기
	public String getToken() {
		String url = "https://api.iamport.kr/users/getToken";
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		Map<String, String> map = new HashMap<String, String>();
		map.put("imp_key", "9641301071926320");
		map.put("imp_secret", "DGvvhuqgbRnvUxwBIwOoU5tDk5AH28ZGPvb7ZCnbtLHnjdZ1JOpETTieYSW11WIRrTYrvmCZ7jnqxnrh");
		HttpEntity<String> entity = new HttpEntity<String>(gson.toJson(map), headers);
		ResponseEntity<String> responseEntity = restTemplate.postForEntity(url, entity, String.class);
		
		String temp = responseEntity.getBody().split("access_token\":\"")[1];
		String token = temp.split("\",")[0];
		System.out.println("token : " + token);
		
		return token;
	}

	//예약 결제
	public void requestSchedulePusrchase(Purchase purchase) {
		String token = getToken();
		String url = "https://api.iamport.kr/subscribe/payments/schedule";
		HttpHeaders headers = new HttpHeaders();
		
		//토큰 세팅
		headers.set("Authorization", token);
		
		//데이터 세팅
		Map<String, Object> data = new HashMap<String, Object>();
		List<Map<String, Object>> schedulesList = new ArrayList<Map<String,Object>>();
		Map<String, Object> schedules = new HashMap<String, Object>();
		
		//결제 시도 시각 설정
		Funding funding = fundingService.selectByCode(purchase.getFundingCode());
		String fundingEndDate = funding.getEndDate();
		String dates[] = fundingEndDate.split("/");
		fundingEndDate = String.format("%s-%s-%s 09:00:00 KST", dates[0], dates[1], dates[2]);
		//System.out.println("fundingEndDate :" + fundingEndDate);
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z", Locale.KOREA);
		
		Date date = null;
		try {
			date = dateformat.parse(fundingEndDate);
		} catch (Exception e) {
			System.out.println("에러");
		}
		//System.out.println(date);
		
		long unixTime = (long)date.getTime()/1000;
		

		//System.out.println("unixTime :" + unixTime);
		//System.out.println("amount :" + purchase.getPrice()*purchase.getQty());
		
		
		
		
		schedules.put("merchant_uid", purchase.getMerchantUid());
		schedules.put("schedule_at", unixTime);
		schedules.put("amount", purchase.getPrice()*purchase.getQty());
		schedulesList.add(schedules);
		
		
		data.put("customer_uid", purchase.getCustomerUid());
		data.put("schedules", schedulesList);
	
		System.out.println("gson.toJson(data)|" + gson.toJson(data));
		//System.out.println("customer_uid " + data.get("customer_uid"));
		//System.out.println("schedules " + schedules);
		
		HttpEntity<String> entity = new HttpEntity<String>(gson.toJson(data), headers);
		
		ResponseEntity<String> responseEntity = restTemplate.postForEntity(url, entity, String.class);
		
		
		
		System.out.println(responseEntity.getBody());
	}
}