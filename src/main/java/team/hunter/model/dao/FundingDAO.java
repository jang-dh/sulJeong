package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Funding;

public interface FundingDAO {
	
	public List<Funding> select(int categoryCode, String order, String where, String val);

	public List<Funding> selectByMdName(int categoryCode, String order, String where, String val);

	public List<Funding> selectLikesOrder(int categoryCode, String order, String where, String val);

	public List<Funding> selectByMdNameLikesOrder(int categoryCode, String order, String where, String val);
}
