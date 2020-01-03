package team.hunter.model.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Purchase;


@Repository
public class PurchaseDAOImpl implements PurchaseDAO {
	
	@Autowired
	private SqlSession session;

	@Override
	public int insertPerchase(Purchase purchase) {
		
		System.out.println(2);
		int result = session.insert("purchaseMapper.insertPerchase", purchase);
		return result;
	}
	

}
