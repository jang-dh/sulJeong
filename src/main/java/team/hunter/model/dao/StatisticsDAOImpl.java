package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StatisticsDAOImpl implements StatisticsDAO {
	
	@Autowired
	private SqlSession session;	
	
	
	
	@Override
	public int insertTodayVisit() {
		
		return session.update("statisticsMapper.insertTodayVisit");
	}



	@Override
	public int updateFundingTotalCount() {
		
		return session.update("statisticsMapper.updateFundingTotalCount");
	}



	@Override
	public int updateFundingApply() {
		
		return session.update("statisticsMapper.updateFundingApply");
	}



	@Override
	public int updateTotalFundingStackPrice(int price) {
		
		return session.update("statisticsMapper.updateTotalFundingStackPrice", price);
	}



	@Override
	public List<StatisticsDAO> selectWeekData() {
		
		return session.selectList("statisticsMapper.selectWeekData");
	}


}
