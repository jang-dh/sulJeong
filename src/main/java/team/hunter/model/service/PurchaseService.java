package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Purchase;

public interface PurchaseService {
	
	/*
	 * 펀딩하기
	 */
	public int insert(Purchase purchase);
	
	/*
	 * 전체검색
	 */
	public List<Purchase> selectAll();
	
	/*
	 *  후원인원 증가
	 */
	public int countFundingCode(int fundingCode);

}
