package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;

public interface FundingQuestionService {
	int questionInsert(FundingRequest fundingRequest); 

	List<FundingQuestion> fundingQuestionList(int memberCode);
	
	FundingQuestion selectByCode(int code);
	
}
