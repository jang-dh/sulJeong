package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingRequestDAO;
import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;


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
//		System.out.println(memberCode+"나오니???");
//		System.out.println(list+"나오니???");
//		for(Funding funding : list) {
//			System.out.println(funding.getCode()+"////////////////");
//			System.out.println(funding.getImage()+"////////////////");
//		}
		return list;
	}

}
