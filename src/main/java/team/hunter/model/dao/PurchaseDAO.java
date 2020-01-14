package team.hunter.model.dao;

import java.util.List;
import java.util.Map;

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
	 * 후원 리스트 상세 정보
	 */
	public List<Purchase> listDetail(int memberCode);
	
	/*
	 * 후원자 정보 출력
	 */
	public int selectListByMemberCode(int code);
	 
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
	
	/**
	 * 우석 : 구매테이블에서 PurchaseState update
	 * */
	int updatePurchaseState();
}
