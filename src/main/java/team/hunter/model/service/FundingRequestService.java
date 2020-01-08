package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Member;

public interface FundingRequestService {

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
	List<FundingQuestion> myFundingOpenDetail(int fundingCode);
	
	/**
	 * 펀딩 디테일 페이지 - 펀딩 참가 사용자 관리
	 * */
	List<Member> myFundingOpenDetailSecond(int fundingCode);
}
