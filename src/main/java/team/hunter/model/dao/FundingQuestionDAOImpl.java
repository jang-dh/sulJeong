package team.hunter.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;

@Repository
public class FundingQuestionDAOImpl implements FundingQuestionDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public int fundingQuestionInsert(FundingQuestion fundingQuestion) {
		int result = session.insert("FundingQuestionMapper.fundingQuestionInsert", fundingQuestion);
		return result;
	}

}
