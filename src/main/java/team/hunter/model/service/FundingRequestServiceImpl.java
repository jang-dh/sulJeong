package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingRequestDAO;
import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingAnswer;
import team.hunter.model.dto.FundingQuestion;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Member;


@Service
public class FundingRequestServiceImpl implements FundingRequestService {

	@Autowired
	private FundingRequestDAO fundingrequestDAO;
	
	@Override
	public int fundingInsert(FundingRequest fundingRequest) {
		int result = fundingrequestDAO.fundingInsert(fundingRequest);
		return result;
	}

	@Override
	public List<Funding> myFundingOpenList(int memberCode) {
		List<Funding> list = fundingrequestDAO.myFundingOpenList(memberCode);
		if(list==null) throw new RuntimeException();
		return list;
	}

//	@Override
//	public List<FundingQuestion> myFundingOpenDetail(int fundingCode) {
//		List<FundingQuestion> list = fundingrequestDAO.myFundingOpenDetail(fundingCode);
//		return list;
//	}

	@Override
	public List<Member> myFundingOpenDetailSecond(int fundingCode) {
		List<Member> list = fundingrequestDAO.myFundingOpenDetailSecond(fundingCode);
		return list;
	}

	@Override
	public FundingQuestion myOpenFundingReqManage(int questionCode) {
		FundingQuestion fundingQuestion = fundingrequestDAO.myOpenFundingReqManage(questionCode);
		return fundingQuestion;
	}

	@Override
	public FundingAnswer myOpenFundingAnswerManage(int questionCode) {
		FundingAnswer fundingAnswer = fundingrequestDAO.myOpenFundingAnswerManage(questionCode);
		return fundingAnswer;
	}

	@Override
	public Funding fundingState(int fundingCode) {
		Funding funding = fundingrequestDAO.fundingState(fundingCode);
		return funding;
	}

	@Override
	public int listCount(int fundingCode) {
		int result = fundingrequestDAO.listCount(fundingCode);
		return result;
	}

	@Override
	public List<FundingQuestion> myFundingOpenDetail(int startIndex, int cntPerPage, int fundingCode) {
		List<FundingQuestion> list = fundingrequestDAO.myFundingOpenDetail(startIndex, cntPerPage, fundingCode);
		return list;
	}
}
