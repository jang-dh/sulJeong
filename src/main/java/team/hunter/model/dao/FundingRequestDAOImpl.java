package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Member;
@Repository
public class FundingRequestDAOImpl implements FundingRequestDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public int fundingInsert(FundingRequest fundingRequest) {
		int result = session.insert("fundingRequestMapper.fundingInsert", fundingRequest);
		return result;
	}

	@Override
	public List<Funding> myFundingOpenList(int memberCode) {
		List<Funding> list = session.selectList("fundingRequestMapper.myFundingOpenList",memberCode);
		return list;
	}

	@Override
	public List<FundingQuestion> myFundingOpenDetail(int fundingCode) {
		List<FundingQuestion> list = session.selectList("fundingRequestMapper.myFundingOpenDetail", fundingCode);
		return list;
	}

	@Override
	public List<Member> myFundingOpenDetailSecond(int fundingCode) {
		List<Member> list = session.selectList("fundingRequestMapper.myFundingOpenDetailUserManage", fundingCode);
		return list;
	}
}
