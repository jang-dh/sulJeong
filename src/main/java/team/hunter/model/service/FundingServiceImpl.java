package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dto.Funding;

@Service
public class FundingServiceImpl implements FundingService {
	@Autowired
	private FundingDAO fundingDAO;
	
	@Override
	public List<Funding> selectList(String categoryCode, String order, String where, String val) {
		//판매자 이름으로 펀딩 검색하고  좋아요순으로 정렬
		if(where != null && where.equals("md_name") && order != null && order.equals("likes"))
			return fundingDAO.selectByMdNameLikesOrder(categoryCode, order, where, val);
		//판매자 이름으로 펀딩 검색
		if(where != null && where.equals("md_name"))
			return fundingDAO.selectByMdName(categoryCode, order, where, val);
		//좋아요 순으로 정렬
		if(order != null && order.equals("likes"))
			return fundingDAO.selectLikesOrder(categoryCode, order, where, val);
		
		return fundingDAO.select(categoryCode, order, where, val);
	}

	@Override
	public Funding selectByCode(int code) {
		return fundingDAO.selectByCode(code);
	}

	@Override
	public List<Funding> selectLikesRankFour() {
		return fundingDAO.selectLikesRankFour();
	}

	@Override
	public List<Funding> selectLastestFour() {
		return fundingDAO.selectLastestFour();
	}

	@Override
	public List<Funding> selectNewestFour() {
		return fundingDAO.selectNewestFour();
	}

	@Override
	@Transactional
	public int updateFundingState() {
		int result = fundingDAO.updateFundingStateClose();
		result += fundingDAO.updateFundingStateOpen();
		return result;
	}

	@Override
	public int fundUpdate(Funding funding) {
		int result = fundingDAO.fundUpdate(funding);
		return result;
	}
}
