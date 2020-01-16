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
	 * 총 성공 후원 횟수
	 */
	public int countPurchaseNumber(int memberCode);
	
	/*
	 * 총 누적 후원 합계
	 */
	public int countTotalPrice(int memberCode);
	
	/*
	 * 후원 리스트 상세 정보
	 */
	public List<Purchase> listDetail(int memberCode);
	 
	/*
	 * 후원 취소 상태 번경
	 */
	public int updatePurchase(int code);

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
	
	/*
	 * 펀딩 후원 신청 갯수 가지고 오기
	 */
	public int purchaseListCount(int memberCode);

	/*
	 * 펀딩등록신청 순서대로 가지고 나오기
	 */
	public List<Purchase> purchaseList(int memberCode, int startIndex, int cntPerPage);
	
	/**
	 * 펀딩 달성 실패로 결제 취소할 결제 내역
	 * */
	public List<Purchase> selectCanceled();
	
	/**
	 * 
	 * */
	public Purchase selectByCode(int code);
}
