package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Purchase;

public interface PurchaseService {
	
	/*
	 * 펀딩하기
	 */
	int insert(Purchase purchase);
	
	/*
	 * 전체검색
	 */
	List<Purchase> selectAll();
	
	

}
