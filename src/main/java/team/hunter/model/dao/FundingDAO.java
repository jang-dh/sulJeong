package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Funding;

public interface FundingDAO {
	public List<Funding> selectAll();
}
