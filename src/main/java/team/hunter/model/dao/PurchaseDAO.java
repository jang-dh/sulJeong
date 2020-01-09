package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Purchase;

public interface PurchaseDAO {
	
	/*
	 * 펀딩하기
	 */
	public int insert(Purchase purchase);
	
	/*
	 * 펀딩내역 보기
	 */
	public List<Purchase> selectAll();
	
	/*
	 * 후원인원 증가
	 */
	Purchase countFundingCode(int fundingCode);
	
	


}
