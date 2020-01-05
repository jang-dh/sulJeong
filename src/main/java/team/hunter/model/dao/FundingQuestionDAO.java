package team.hunter.model.dao;

import team.hunter.model.dto.FundingRequest;

public interface FundingQuestionDAO {
	/*
	 * 펀딩 문의 등록하기
	 */
	int questionInsert(FundingRequest fundingRequest);

}
