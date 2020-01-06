package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.FundingQuestion;

public interface FundingQuestionService {
	List<FundingQuestion> fundingQuestionList(int memberCode);
}
