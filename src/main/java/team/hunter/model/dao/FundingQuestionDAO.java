package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.FundingQuestion;

public interface FundingQuestionDAO {
	List<FundingQuestion> fundingQuestionList(int memberCode);
}
