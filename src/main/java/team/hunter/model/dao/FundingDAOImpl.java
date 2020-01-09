package team.hunter.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Funding;

@Repository
public class FundingDAOImpl implements FundingDAO {
	@Autowired
	private SqlSession session;

	@Override
	public List<Funding> select(String categoryCode, String order, String where, String val) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", categoryCode);
		map.put("order", order);
		map.put("where", where);
		map.put("val", val);
		
		System.out.println("call dao.select");
		System.out.println("cate : " + categoryCode);
		System.out.println("order : " + order);
		System.out.println("where : " + where);
		System.out.println("val : " + val);
		return session.selectList("fundingMapper.select", map);
	}

	@Override
	public List<Funding> selectByMdName(String categoryCode, String order, String where, String val) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("category", categoryCode);
		map.put("order", order);
		map.put("where", where);
		map.put("val", val);
		
		System.out.println("call dao.selectByMdName");
		System.out.println("cate : " + categoryCode);
		System.out.println("order : " + order);
		System.out.println("where : " + where);
		System.out.println("val : " + val);
		return session.selectList("fundingMapper.selectByMdName", map);
	}

	@Override
	public List<Funding> selectLikesOrder(String categoryCode, String order, String where, String val) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("category", categoryCode);
		map.put("order", order);
		map.put("where", where);
		map.put("val", val);
		
		System.out.println("call dao.selectLikesOrder");
		System.out.println("cate : " + categoryCode);
		System.out.println("order : " + order);
		System.out.println("where : " + where);
		System.out.println("val : " + val);
		return session.selectList("fundingMapper.selectLikesOrder", map);
	}

	@Override
	public List<Funding> selectByMdNameLikesOrder(String categoryCode, String order, String where, String val) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("category", categoryCode);
		map.put("order", order);
		map.put("where", where);
		map.put("val", val);
		
		System.out.println("call dao.selectByMdNameLikesOrder");
		System.out.println("cate : " + categoryCode);
		System.out.println("order : " + order);
		System.out.println("where : " + where);
		System.out.println("val : " + val);
		return session.selectList("fundingMapper.selectByMdNameLikesOrder", map);
	}

	@Override
	public Funding selectByCode(int code) {
		return session.selectOne("fundingMapper.selectByCode", code);
	}

	@Override
	public List<Funding> selectLikesRankFour() {
		return session.selectList("fundingMapper.selectLikesRankFour");
		
	}

	@Override
	public List<Funding> selectLastestFour() {
		return session.selectList("fundingMapper.selectLastestFour");
	}

	@Override
	public List<Funding> selectNewestFour() {
		return session.selectList("fundingMapper.selectNewestFour");
	}

	@Override
	public int updateFundingStateOpen() {
		return session.update("fundingMapper.updateFundingStateOpen");
	}

	@Override
	public int updateFundingStateClose() {
		return session.update("fundingMapper.updateFundingStateClose");
	}
	
	@Override
	public int updateStackPrice() {
		return session.update("fundingMapper.updateStackPrice");
	}
}