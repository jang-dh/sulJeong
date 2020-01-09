package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingQuestionDAO;
import team.hunter.model.dto.FundingQuestion;

@Service
public class FundingQuestionServiceImpl implements FundingQuestionService {
	
	@Autowired
	private FundingQuestionDAO fundingQuestionDAO;

	@Override
	public int insert(FundingQuestion fundingQuestion) {
		int result = fundingQuestionDAO.insert(fundingQuestion);
		return result;
	}


	@Override
	public List<FundingQuestion> fundingQuestionList(int memberCode) {
		List<FundingQuestion> list = fundingQuestionDAO.fundingQuestionList(memberCode);
		return list;
	}


	@Override
	public FundingQuestion selectByCode(int code) {
		FundingQuestion fundingQuestion = fundingQuestionDAO.selectByCode(code);
		return fundingQuestion;
	}


}
