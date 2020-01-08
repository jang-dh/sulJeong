package team.hunter.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.FundingAnswer;
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

}
