package team.hunter.model.service;

import org.springframework.beans.factory.annotation.Autowired;

import team.hunter.model.dao.FundingQuestionDAO;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;

public class FundingQuestionServiceImpl implements FundingQuestionService {
	
	@Autowired
	private FundingQuestionDAO fundingQuestionDAO;

	@Override
	public int fundingQuestionInsert(FundingQuestion fundingQuestion) {
		int result = fundingQuestionDAO.fundingQuestionInsert(fundingQuestion);
		return result;
	}

}
