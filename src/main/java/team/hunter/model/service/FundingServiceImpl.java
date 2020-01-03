package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dto.Funding;

@Service
public class FundingServiceImpl implements FundingService {
	@Autowired
	private FundingDAO fundingDAO;
	
	@Override
	public List<Funding> selectAll() {
		return fundingDAO.selectAll();
	}

	@Override
	public List<Funding> selectByCategory(int categoryCode, String order, String where, String val) {
		return fundingDAO.selectByCategory(categoryCode, order, where, val);
	}
	
	

}
