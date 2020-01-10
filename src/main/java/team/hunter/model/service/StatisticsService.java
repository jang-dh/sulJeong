package team.hunter.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import team.hunter.model.dao.StatisticsDAO;
import team.hunter.model.dto.Statistics;

public interface StatisticsService {
	/**
	 * 오늘방문자 수 
	 * 업뎃
	 * */
	int insertTodayVisit();
	
	/**
	 * 일반 사용자들이 
	 * 펀딩을 요청한 총 횟수 누적
	 * */
	int updateFundingTotalCount();
	
	/**
	 * 관리자가 등록한
	 * 펀딩의 총 횟수 누적
	 * */
	int updateFundingApply();
	
	/**
	 * 일반 사용자들이 
	 * 펀딩을 요청 후
	 * 결제한 금액 누적 양
	 * */
	int updateTotalFundingStackPrice(int price);
	
	
	/**
	 * 당일기준 일주일 전까지의
	 * 통계정보 출력
	 * */
	List<Statistics> selectWeekData();

}
