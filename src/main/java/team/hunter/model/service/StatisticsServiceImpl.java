package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.StatisticsDAO;
import team.hunter.model.dto.Statistics;

@Service
public class StatisticsServiceImpl implements StatisticsService {

	@Autowired
	private StatisticsDAO dao;
	
	@Override
	public int insertTodayVisit() {
		int result = dao.insertTodayVisit();
		if(result==0) throw new RuntimeException();
		return result;
	}

	@Override
	public int updateFundingTotalCount() {
		int result = dao.updateFundingTotalCount();
		if(result==0) throw new RuntimeException();
		return result;
	}

	@Override
	public int updateFundingApply() {
		int result = dao.updateFundingApply();
		if(result==0) throw new RuntimeException();
		return result;
	}

	@Override
	public int updateTotalFundingStackPrice(int price) {
		int result = dao.updateTotalFundingStackPrice(price);
		if(result==0) throw new RuntimeException();
		return result;
	}

	@Override
	public List<Statistics> selectWeekData() {
		List<Statistics> list = dao.selectWeekData();
		if(list ==null) throw new RuntimeException();
		return list;
	}

}
