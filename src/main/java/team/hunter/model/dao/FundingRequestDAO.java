package team.hunter.model.dao;

import team.hunter.model.dto.FundingRequest;

public interface FundingRequestDAO {

	/**
	 * 펀딩신청
	 * */
	int fundingInsert(FundingRequest fundingRequest);
}
