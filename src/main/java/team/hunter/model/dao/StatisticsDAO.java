package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Statistics;

public interface StatisticsDAO {
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
	
	/*
	 * 근딘 :
	 * 후원한 펀딩 내역에서
	 * 후원 취소 했을 때
	 * 결제한 누적 금액 양에서 차감
	 */
	int updateFurchaseFailed(int price);
	
	/**
	 * 당일기준 일주일 전까지의
	 * 통계정보 출력
	 * */
	List<Statistics> selectWeekData();

}
