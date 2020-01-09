package team.hunter.model.service;

import team.hunter.model.dto.FundingQuestion;

import java.util.List;


public interface FundingQuestionService {
  int insert(FundingQuestion fundingQuestion); 
  

	List<FundingQuestion> fundingQuestionList(int memberCode);
	
	FundingQuestion selectByCode(int code);
	

}
