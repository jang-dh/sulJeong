package team.hunter.model.service;

import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Notice;

public interface NoticeService {
	/**
	* 코드번호로 검색
	 * */
	Notice selectByCode(int code);
	
	/**
	* 전체검색
	 * */
	List<Notice> select();
		
	/**
	* 공지사항 등록
	* */
	int insert(Notice dto);
		
	/**
	* 공지사항 삭제
	* */
	int delete(int code);
	
	/**
	 * 공지사항 수정
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
	int fundInsert(Funding funding, int code);
	
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
	
}
