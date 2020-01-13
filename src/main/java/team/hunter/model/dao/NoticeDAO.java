package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Notice;

public interface NoticeDAO {
	/**
	* ��ü���
	 * */
	Notice selectByCode(int code);
	
	/**
	* �󼼺���
	 * */
	List<Notice> select();
		
	/**
	* ���
	* */
	int insert(Notice dto);
		
	/**
	* ����
	* */
	int delete(int code);
	
	/**
	 * �Խù� ����
	 * */
	int update(Notice code);
	
	/**
	 * 펀딩 등록 전에 
	 * 펀딩신청자 목록 가지고 오기
	 * */
	List<FundingRequest> selectFundingRequest();

	/**
	 * 펀딩 등록하기
	 * */
	int fundInsert(Funding funding);
	
	/**
	 * 펀딩등록할 때
	 * 펀딩신청 상태변경
	 * */
	int fundingRequestStateChange(int code);
	
	/**
	 * FundingRequest 상세보기
	 * */
	FundingRequest selectFundingRequestByCode(int code);
	
	/**
	 * 펀딩등록 신청 거절하기
	 * */
	int fundingRequestReject(int code);
	
	/**
	 * 펀딩등록 신청 승인하기
	 * */
	int fundingRequestApprove(int code);
	
	/**
	 * 공지사항 갯수 가지고 오기
	 * */
	int listCount();
	
	/**
	 * 공지사항 순서대로 가지고 나오기
	 * */
	List<Notice> NoticeList(int startIndex, int cntPerPage);
	
	/**
	 * 펀딩등록신청 갯수 가지고 오기
	 * */
	int fundingRequestlistCount();
	
	/**
	 * 펀딩등록신청 순서대로 가지고 나오기
	 * */
	List<FundingRequest> fundingRequestList(int startIndex, int cntPerPage);
	
	/**
	 * 매일 통계 테이블 insert해주기
	 * */
	int insertStatistics();
}
