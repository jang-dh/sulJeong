package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Purchase;

public interface PurchaseDAO {
	
	/*
	 * 펀딩하기
	 */
	int insert(Purchase purchase);
	
	/*
	 * 펀딩내역보기
	 */
	List<Purchase> selectAll();


}
