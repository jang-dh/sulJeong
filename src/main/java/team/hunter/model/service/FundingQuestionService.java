package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Member;

public interface FundingQuestionService {
  int insert(FundingQuestion fundingQuestion); 
  

	List<FundingQuestion> fundingQuestionList(Member member);
	
	FundingQuestion selectByCode(int code);
	
	int listCount(int memberCode);
}
