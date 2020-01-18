package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingAnswer;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Member;

public interface FundingRequestDAO {

	/**
	 * 펀딩신청
	 * */
	int fundingInsert(FundingRequest fundingRequest);
	
	/**
	 * 내가 만든 펀딩 목록
	 * */
	List<Funding> myFundingOpenList(int memberCode);
	
	/**
	 * 펀딩 디테일 페이지 - 펀딩 문의 관리
	 * */
	//List<FundingQuestion> myFundingOpenDetail(int fundingCode);
	
	/**
	 * 펀딩 디테일 페이지 - 펀딩 참가 사용자 관리
	 * */
	List<Member> myFundingOpenDetailSecond(int fundingCode);
	
	/**
	 * 펀딩 디테일 페이지 - 펀딩 문의 관리 상세페이지(문의내용)
	 * */
	FundingQuestion myOpenFundingReqManage(int questionCode);
	
	/**
	 * 펀딩 디테일 페이지 - 펀딩 문의 관리 상세페이지(답변내용)
	 * */
	FundingAnswer myOpenFundingAnswerManage(int questionCode);
	
	/**
	 * 펀딩 상태 조회
	 * */
	Funding fundingState(int fundingCode);
	
	/**
	 * 페이징 처리 위한 갯수
	 * */
	int listCount(int fundingCode);
	
	/**
	 * 페이징 처리 - 펀딩 문의 관리 
	 * */
	List<FundingQuestion> myFundingOpenDetail(int startIndex, int cntPerPage, int fundingCode);
}
