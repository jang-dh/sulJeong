package team.hunter.model.dao;

import java.util.List;

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

}
