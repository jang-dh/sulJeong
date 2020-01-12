package team.hunter.model.service;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.google.api.client.http.HttpHeaders;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Purchase;

@Service
public class PurchaseSchedule {
	RestTemplate restTemplate = new RestTemplate(new HttpComponentsClientHttpRequestFactory());
	
	@Autowired
	FundingService fundingService;
	
	//결제 서비스에 대한 토큰 얻기
	public String getToken() {
		String url = "https://api.iamport.kr/users/getToken";
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType("application/json");
		Map<String, String> map = new HashMap<String, String>();
		map.put("imp_key", "9641301071926320");
		map.put("imp_secret", "DGvvhuqgbRnvUxwBIwOoU5tDk5AH28ZGPvb7ZCnbtLHnjdZ1JOpETTieYSW11WIRrTYrvmCZ7jnqxnrh");
		
		//url에 대한 요청
		ResponseEntity<String> responseEntity = restTemplate.postForEntity(url, map, String.class);
		String temp = responseEntity.getBody().split("access_token\":\"")[1];
		String token = temp.split("\",")[0];
			
		System.out.println("token : " + token);
		
		return token;
	}
	
	//예약 결제
	public void requestSchedulePusrchase(Purchase purchase) throws ParseException {
		String token = getToken();
		String url = "https://api.iamport.kr/subscribe/payments/schedule";
		HttpHeaders headers = new HttpHeaders();
		
		//토큰 세팅
		//headers.set("Authorization", token);
		headers.setAuthorization(token);
				
		//데이터 세팅
		Map<String, Object> data = new HashMap<String, Object>();
		//data.put("customer_uid", purchase.getCustomerUid());
		Map<String, Object> schedules = new HashMap<String, Object>();
		//schedules.put("merchant_uid", purchase.getMarchantUid());
		
		//결제 시도 시각 설정
		Funding funding = fundingService.selectByCode(purchase.getFundingCode());
		String fundingEndDate = funding.getEndDate();
		String dates[] = fundingEndDate.split("/");
		fundingEndDate = String.format("%s-%s-%s 00:00:00 KST", dates[0], dates[1], dates[2]);
		System.out.println(fundingEndDate);
		
		DateFormat dateformat = new SimpleDateFormat("YYYY-MM-DD HH:mm:ss z", Locale.KOREA);
		Date date = dateformat.parse(fundingEndDate);
		System.out.println(date);
		long unixTime = (long)date.getTime()/1000;
		Timestamp ts = new Timestamp(unixTime);
		System.out.println(ts);
		System.out.println(unixTime);
		schedules.put("schedule_at", ts);
		schedules.put("amount", Integer.toString(purchase.getPrice()*purchase.getQty()));
	}
}
