package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Member;
import team.hunter.model.dto.Funding;
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
	 * 펀딩 이름과 받는 사람 정보 표시
	 */
	Funding recipientInformation(int fundingCode);
	 
	/*
	 * 후원한 펀딩 삭제
	 */
	public int deleteList(int code);
	

	/**
	 * 송장번호, 택배사 입력
	 * */
	public int deliveryCodeSave(Purchase purchase);
	
	/**
	 * 송장번호, 택배사, 맴버정보 조회
	 * */
	public Member deliveryCodeSelect(int fundingCode, int memberCode);

}
