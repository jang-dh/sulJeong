package team.hunter.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingRequestDAO;
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

}
