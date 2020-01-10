package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.Member;

@Repository
public class FundingQuestionDAOImpl implements FundingQuestionDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public int insert(FundingQuestion fundingQuestion) {
		int result = session.insert("fundingQuestionMapper.fundingQuestionInsert", fundingQuestion);
		return result;
	}
	@Override
	public List<FundingQuestion> fundingQuestionList(Member member) {
		return session.selectList("fundingQuestionMapper.fundingQuestionList", member);
	}
	@Override
	public FundingQuestion selectByCode(int code) {
		FundingQuestion fundingQuestion = session.selectOne("fundingQuestionMapper.selectByCode", code);
		return fundingQuestion;
	}
	@Override
	public int listCount(int memberCode) {
		return session.selectOne("fundingQuestionMapper.listCount",memberCode);
	}
	

}


