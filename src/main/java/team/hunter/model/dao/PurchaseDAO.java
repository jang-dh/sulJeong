package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Purchase;

public interface PurchaseDAO {
	
	/*
	 * 펀딩하기
	 */
	public int insert(Purchase purchase);
	
	/*
	 * 후원인원 증가
	 */
	public int countFundingCode(int fundingCode);
	
	/*
	 * 펀딩내역 보기
	 */
	public List<Purchase> myPurchaseList(int memberCode);
	 
	/*
	 * 후원한 펀딩 삭제
	 */
	public int deleteList(int code);
	


}
