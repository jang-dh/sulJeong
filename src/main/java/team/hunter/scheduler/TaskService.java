package team.hunter.scheduler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dto.Funding;
import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dao.StatisticsDAO;
import team.hunter.model.service.FundingService;
import team.hunter.model.service.NoticeService;
import team.hunter.model.dto.Purchase;
import team.hunter.model.service.PurchaseService;
import team.hunter.model.service.PurchaseServiceImpl;
import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dao.NoticeDAO;
import team.hunter.model.dao.PurchaseDAO;

@Service
public class TaskService {
	@Autowired
	private FundingDAO fundingDAO;
	
	@Autowired
	private NoticeDAO noticeDAO;
	
	@Autowired
	private PurchaseDAO purchaseDAO;
	
	@Autowired
	private PurchaseService purchaseService;
	
	//@Scheduled(cron = "0 0/30 0 * * *")
	@Scheduled(cron="1 0 0 * * *")//매일 0시 0분 1초에 실행
	public void scheduler() {
		updateDB();
		
		//취소할 결제 목록
		List<Purchase> canceledList = purchaseDAO.selectCanceled();
		
		//결제 취소
		for(Purchase purchase : canceledList) {
			purchaseService.cancelPurchase(purchase);
		}
			
	}
	
	@Transactional
	public void updateDB() {
		//자정이 지나면
		System.out.println("call scheduler");
		//statistics 테이블에 레코드 추가
		noticeDAO.insertStatistics();
		
		//펀딩 마감 및 오픈
		fundingDAO.updateFundingStateClose();
		fundingDAO.updateFundingStateOpen();
		
		//구매 상태 변경
		purchaseDAO.updatePurchaseState();
	}

}
