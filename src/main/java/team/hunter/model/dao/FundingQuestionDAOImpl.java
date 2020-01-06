package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.FundingQuestion;
@Repository
public class FundingQuestionDAOImpl implements FundingQuestionDAO {
	@Autowired
	private SqlSession session;
	
	@Override
	public List<FundingQuestion> fundingQuestionList(int memberCode) {
		session.selectList("fundingQuestionMapper.fundingQuestionList", memberCode);
		return null;
	}

}
