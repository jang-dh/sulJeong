package team.hunter.model.service;

import team.hunter.model.dto.FundingRequest;

public interface FundingRequestService {

	/**
	 * 펀딩신청
	 * */
	int fundingInsert(FundingRequest fundingRequest);
}
