package team.hunter.model.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Purchase;


@Repository
public class PurchaseDAOImpl implements PurchaseDAO {
	
	@Autowired
	private SqlSession session;
	
	@Override
	public int insert(Purchase purchase) {
		
		System.out.println(2);
		return session.insert("purchaseMapper.insert", purchase);
	}
	
	@Override
	public List<Purchase> selectAll() {
		return session.selectList("purchaseMapper.selectAll");
	}

}
