package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Purchase;

public interface PurchaseService {
	
	/*
	 * 펀딩하기
	 */
	public int insert(Purchase purchase);
	
	/*
	 * 후원인원 증가
	 */
	public int countFundingCode(int fundingCode);
	
	/*
	 * 전체검색
	 */
	public List<Purchase> myPurchaseList(int memberCode);
	
	/*
	 * 후원한 펀딩 삭제
	 */
	public int deletePurchaseList(int code);
	
	/**
	 * 송장번호, 택배사 입력
	 * */
	public int deliveryCodeSave(Purchase purchase);
	

}
