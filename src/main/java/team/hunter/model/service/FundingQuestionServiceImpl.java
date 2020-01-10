package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingQuestionDAO;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Member;

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
	public List<FundingQuestion> fundingQuestionList(Member member) {
		List<FundingQuestion> list = fundingQuestionDAO.fundingQuestionList(member);
		return list;
	}


	@Override
	public FundingQuestion selectByCode(int code) {
		FundingQuestion fundingQuestion = fundingQuestionDAO.selectByCode(code);
		return fundingQuestion;
	}


	@Override
	public int listCount(int memberCode) {
		
		return fundingQuestionDAO.listCount(memberCode);
	}

}
