package team.hunter.scheduler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dao.StatisticsDAO;
import team.hunter.model.service.FundingService;
import team.hunter.model.service.NoticeService;

@Service
public class TaskService {
	@Autowired
	private FundingService fundingService;
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private FundingDAO fundingDAO;
	
	@Autowired
	private StatisticsDAO statisticsDAO;
	
	//@Scheduled(cron = "0 0/30 0 * * *")
	// @Scheduled(cron="1 0 0 * * *")//매일 0시 0분 1초에 실행
	public void TestScheduler() {
		System.out.println("call updateFunding");
		fundingService.updateFundingState();
	}
	
	@Scheduled(cron = "0 30 09 * * * ")
	public void statisticsScheduler() {
		System.out.println("call statisticsScheduler....");
		noticeService.insertStatistics();
	}
}
