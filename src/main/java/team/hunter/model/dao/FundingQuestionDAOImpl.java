package team.hunter.model.dao;

import java.util.List;

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
	public int questionInsert(FundingRequest fundingRequest) {
		int result = session.insert("FundingQuestionMapper.insertQuestion", fundingRequest);
		return result;
	}
	@Override
	public List<FundingQuestion> fundingQuestionList(int memberCode) {
		session.selectList("fundingQuestionMapper.fundingQuestionList", memberCode);
		return null;
	}

}
