package team.hunter.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.FundingRequest;

@Repository
public class FundingQuestionDAOImpl implements FundingQuestionDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public int questionInsert(FundingRequest fundingRequest) {
		int result = session.insert("FundingQuestionMapper.insertQuestion", fundingRequest);
		return result;
	}

}
