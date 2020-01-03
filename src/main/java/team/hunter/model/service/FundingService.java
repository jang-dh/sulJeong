package team.hunter.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import team.hunter.model.dto.Funding;

@Service
public interface FundingService {
	public List<Funding> selectAll();
}
