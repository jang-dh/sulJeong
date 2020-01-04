package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Funding;

public interface FundingDAO {
	public List<Funding> selectAll();
	
	public List<Funding> selectByCategory(int categoryCode, String order, String where, String val);

	public List<Funding> selectByMdName(int categoryCode, String order, String where, String val);

}
