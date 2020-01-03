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
	public List<Funding> selectAll() {
		return session.selectList("fundingMapper.select");
	}

	@Override
	public List<Funding> selectByCategory(int categoryCode, String order, String where, String val) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("category", Integer.toString(categoryCode));
		map.put("order", order);
		map.put("where", where);
		map.put("val", val);
		return session.selectList("fundingMapper.select", map);
	}

}
