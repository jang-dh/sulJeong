package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Funding;
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
}
