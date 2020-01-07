package team.hunter.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.FundingRequest;
@Repository
public class FundingRequestDAOImpl implements FundingRequestDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public int fundingInsert(FundingRequest fundingRequest) {
		int result = session.insert("fundingRequestMapper.fundingInsert", fundingRequest);
		return result;
	}

}
