package team.hunter.model.service;

import team.hunter.model.dto.FundingQuestion;

import java.util.List;

import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;

public interface FundingQuestionService {
  int insert(FundingQuestion fundingQuestion); 
  
	int questionInsert(FundingRequest fundingRequest); 

	List<FundingQuestion> fundingQuestionList(int memberCode);
	
	FundingQuestion selectByCode(int code);
}
