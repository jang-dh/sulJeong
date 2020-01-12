package team.hunter.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional
	@Override
	public int fundingAnswerinsert(FundingAnswer fundingAnswer) {
		//답변 삽입
		int result = fundingAnswerDAO.fundingAnswerinsert(fundingAnswer);
		if(result>0) {
			//답변 삽입 되면 상태 코드 답변 등록으로 바꿈
			fundingAnswerDAO.updateAnswerCode(fundingAnswer.getQuestionCode());
		}
		return result;
	}
}
