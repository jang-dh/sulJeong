package team.hunter.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.FundingQuestion;

@Repository
public class FundingQuestionDAOImpl implements FundingQuestionDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public int insert(FundingQuestion fundingQuestion) {
		int result = session.insert("fundingQuestionMapper.fundingQuestionInsert", fundingQuestion);
		return result;
	}

}
