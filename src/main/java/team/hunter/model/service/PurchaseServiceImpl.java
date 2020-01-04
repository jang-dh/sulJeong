package team.hunter.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import team.hunter.model.dao.PurchaseDAO;
import team.hunter.model.dto.Purchase;

@Service
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	private PurchaseDAO purchaseDAO;

	@Override
	public int insertPerchase(Purchase purchase) {
		
		System.out.println(1);
		int result = purchaseDAO.insertPerchase(purchase);
		//if(result==0) throw new RuntimeException("삽입실패");
		return result;
	}

}
