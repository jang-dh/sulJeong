package team.hunter.model.dao;

import team.hunter.model.dto.FundingAnswer;

public interface FundingAnswerDAO {
	
	int contentInsert(FundingAnswer fundingAnswer);
	
	FundingAnswer selectByCode(int code);

}
