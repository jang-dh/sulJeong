package team.hunter.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingAnswerDAO;
import team.hunter.model.dto.FundingAnswer;
@Service
public class FundingAnswerServiceImpl implements FundingAnswerService {
	@Autowired
	private FundingAnswerDAO fundingAnswerDAO;

	@Override
	public int contentInsert(FundingAnswer fundingAnswer) {
		fundingAnswerDAO.contentInsert(fundingAnswer);
		return 0;
	}

	@Override
	public FundingAnswer selectByCode(int code) {
		FundingAnswer fundingAnswerDB = fundingAnswerDAO.selectByCode(code);
		return fundingAnswerDB;
	}

}
