package team.hunter.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.FundingAnswer;
import team.hunter.model.dto.FundingQuestion;
@Repository
public class FundingAnswerDAOImpl implements FundingAnswerDAO {
	@Autowired
	private SqlSession session;

	@Override
	public int contentInsert(FundingAnswer fundingAnswer) {
		return session.insert("fundingAnswerMapper.contentInsert", fundingAnswer);
	}

	@Override
	public FundingAnswer selectByCode(int code) {
		return session.selectOne("fundingAnswerMapper.selectByCode", code);
	}
	
	@Override
	public int fundingAnswerinsert(FundingAnswer fundingAnswer) {
		int result = session.insert("fundingAnswerMapper.fundingAnswerInsert", fundingAnswer);
		return result;
	}

	@Override
	public int updateAnswerCode(int code) {
		int result = session.update("fundingAnswerMapper.fundingAnswerState", code);
		return result;
	}

	@Override
	public FundingQuestion selectByCodeQuestion(int code) {
		return session.selectOne("fundingAnswerMapper.selectByCodeQuestion",code);
	}

}
