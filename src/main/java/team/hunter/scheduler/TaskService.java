package team.hunter.scheduler;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dto.Purchase;
import team.hunter.model.email.SendMailPeople;
import team.hunter.model.service.PurchaseService;
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
	
	@Autowired
	private SendMailPeople sendMailPeople;
	
	//@Scheduled(cron = "0 0/30 0 * * *")
	//@Scheduled(cron="0/5 * * * * *")//매일 0시 0분 1초에 실행
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

//	@Scheduled(cron = "0 0/1 * * * *")
//	public void mail() {
//		//SendMailPeople sendMailPeople = new SendMailPeople();
//		System.out.println("call mail");
//		try {
//			sendMailPeople.mailSuccessSending();//펀딩 성공 시 이메일
//			sendMailPeople.mailFailSending(); //펀딩 실패 시 이메일
//			sendMailPeople.mailBeforeSending();//후원 한 사람에게 마감 1일 전 이메일
//			sendMailPeople.mailBeforeSendingLikes();// 좋아요 누른 사람에게 해당 펀딩 마감 1일 전 이메일
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}
