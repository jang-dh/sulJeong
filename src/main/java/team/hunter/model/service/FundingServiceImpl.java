package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dao.LikesDAO;
import team.hunter.model.dto.Funding;

@Service
public class FundingServiceImpl implements FundingService {
	@Autowired
	private FundingDAO fundingDAO;
	
	@Autowired
	private LikesDAO likesDAO;
	
	@Override
	public List<Funding> selectList(String categoryCode, String order, String where, String val) {
		List<Funding> list = null;
		
		//판매자 이름으로 펀딩 검색하고  좋아요순으로 정렬
		if(where != null && where.equals("md_name") && order != null && order.equals("likes"))
			list = fundingDAO.selectByMdNameLikesOrder(categoryCode, order, where, val);
		//판매자 이름으로 펀딩 검색
		else if(where != null && where.equals("md_name"))
			list = fundingDAO.selectByMdName(categoryCode, order, where, val);
		//좋아요 순으로 정렬
		else if(order != null && order.equals("likes"))
			list = fundingDAO.selectLikesOrder(categoryCode, order, where, val);
		else
			list = fundingDAO.select(categoryCode, order, where, val);
		
		for(Funding funding : list)
			funding.setCnt(likesDAO.cntByFundingCode(funding.getCode()));
		
		return list;
	}

	@Override
	public Funding selectByCode(int code) {
		return fundingDAO.selectByCode(code);
	}

	@Override
	public List<Funding> selectLikesRankFour() {
		List<Funding> list = fundingDAO.selectLikesRankFour();
		for(Funding funding : list)
			funding.setCnt(likesDAO.cntByFundingCode(funding.getCode()));
		return list;
	}

	@Override
	public List<Funding> selectLastestFour() {
		List<Funding> list = fundingDAO.selectLastestFour();
		for(Funding funding : list)
			funding.setCnt(likesDAO.cntByFundingCode(funding.getCode()));
		return list;
	}

	@Override
	public List<Funding> selectNewestFour() {
		List<Funding> list = fundingDAO.selectNewestFour();
		for(Funding funding : list)
			funding.setCnt(likesDAO.cntByFundingCode(funding.getCode()));
		return list;
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
