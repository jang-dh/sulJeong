package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingQuestionDAO;
import team.hunter.model.dto.FundingQuestion;
@Service
public class FundingQuestionServiceImpl implements FundingQuestionService {
	@Autowired
	private FundingQuestionDAO fundingqDAO;

	@Override
	public List<FundingQuestion> fundingQuestionList(int memberCode) {
		List<FundingQuestion> list = fundingqDAO.fundingQuestionList(memberCode);
		return null;
	}

}
