package team.hunter.model.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Purchase;


@Repository
public class PurchaseDAOImpl implements PurchaseDAO {
	
	@Autowired
	private SqlSession session;
	
	@Override
	public int insert(Purchase purchase) {
		
		System.out.println("Dao : " + purchase);
		return session.insert("purchaseMapper.insert", purchase);
	}
	
	@Override
	public List<Purchase> selectAll() {
		return session.selectList("purchaseMapper.selectAll");
	}
	
	@Override
	public int countFundingCode(int fundingCode) {
		
		System.out.println("전");
		int fundingSponserCount = session.selectOne("purchaseMapper.countFundingCode", fundingCode);
		
		System.out.println("후");
		return fundingSponserCount;
	}

}
