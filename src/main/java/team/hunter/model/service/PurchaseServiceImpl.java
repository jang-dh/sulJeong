package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.PurchaseDAO;
import team.hunter.model.dto.Purchase;

@Service
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	private PurchaseDAO purchaseDAO;

	@Override
	public int insert(Purchase purchase) {
		System.out.println("service : " + purchase);
		int result = purchaseDAO.insert(purchase);
		return result;
	}
	
	@Override
	public List<Purchase> selectAll() {
		List<Purchase> list = purchaseDAO.selectAll();
		return list;
	}

}
