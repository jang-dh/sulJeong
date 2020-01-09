package team.hunter.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import team.hunter.model.service.FundingService;

@Service
public class TaskService {
	@Autowired
	private FundingService fundingService;
	
	//@Scheduled(cron = "0 0/30 0 * * *")
	// @Scheduled(cron="1 0 0 * * *")//매일 0시 0분 1초에 실행
	public void TestScheduler() {
		System.out.println("call updateFunding");
		fundingService.updateFundingState();
	}
}
