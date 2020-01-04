package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Funding;

public interface FundingService {
		public List<Funding> selectList(int categoryCode, String order, String where, String val);

}
