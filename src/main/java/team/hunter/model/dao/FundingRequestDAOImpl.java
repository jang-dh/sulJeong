package team.hunter.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingAnswer;
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

	//@Override
//	public List<FundingQuestion> myFundingOpenDetail(int fundingCode) {
//		List<FundingQuestion> list = session.selectList("fundingRequestMapper.myFundingOpenDetail", fundingCode);
//		return list;
//	}

	@Override
	public List<Member> myFundingOpenDetailSecond(int fundingCode) {
		List<Member> list = session.selectList("fundingRequestMapper.myFundingOpenDetailUserManage", fundingCode);
		return list;
	}

	@Override
	public FundingQuestion myOpenFundingReqManage(int questionCode) {
		FundingQuestion fundingQuestion = session.selectOne("fundingRequestMapper.myFundingOpenDetailsDetail", questionCode);
		return fundingQuestion;
	}

	@Override
	public FundingAnswer myOpenFundingAnswerManage(int questionCode) {
		FundingAnswer fundingAnswer = session.selectOne("fundingRequestMapper.myFundingOpenAnswerDetail", questionCode);
		return fundingAnswer;
	}

	@Override
	public Funding fundingState(int fundingCode) {
		Funding funding = session.selectOne("fundingRequestMapper.fundingState",fundingCode);
		return funding;
	}

	@Override
	public int listCount(int fundingCode) {
		int result = session.selectOne("fundingRequestMapper.listCount",fundingCode);
		System.out.println("result" + result);
		return result;
	}

	@Override
	public List<FundingQuestion> myFundingOpenDetail(int startIndex, int cntPerPage, int fundingCode) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startIndex", startIndex);
		map.put("cntPerPage", cntPerPage);
		map.put("fundingCode", fundingCode);
		return session.selectList("fundingRequestMapper.myFundingOpenDetail",map);
	}
}
