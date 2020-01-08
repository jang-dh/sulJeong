package team.hunter.model.service;

import team.hunter.model.dto.FundingAnswer;

public interface FundingAnswerService {
	int contentInsert(FundingAnswer fundingAnswer);
	
	FundingAnswer selectByCode(int code);
}
