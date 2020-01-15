package team.hunter.scheduler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import team.hunter.model.dto.Funding;
import team.hunter.model.service.FundingService;
import team.hunter.model.service.NoticeService;
import team.hunter.model.service.PurchaseService;

@Service
public class TaskService {
	@Autowired
	private FundingService fundingService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private PurchaseService purchaseService;
	
	//@Scheduled(cron = "0 0/30 0 * * *")
	@Scheduled(cron="1 20 09 * * *")//매일 0시 0분 1초에 실행
	public void TestScheduler() {
		System.out.println("call updateFunding...");
		fundingService.updateFundingState();
	}
	
	@Scheduled(cron = "1 25 09 * * * ")
	public void purchaseStateUpdateScheduler() {
		System.out.println("call purchaseStateUpdateScheduler...");
		purchaseService.updatePurchaseState();		
	}
	
	@Scheduled(cron = "0 30 09 * * * ")
	public void statisticsScheduler() {
		System.out.println("call statisticsScheduler....");
		noticeService.insertStatistics();
	}
}
