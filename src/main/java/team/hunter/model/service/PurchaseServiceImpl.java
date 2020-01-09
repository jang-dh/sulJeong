package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dao.PurchaseDAO;
import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Purchase;

@Service
public class PurchaseServiceImpl implements PurchaseService {
	
	@Autowired
	private PurchaseDAO purchaseDAO;
	
	@Autowired
	private FundingDAO fundingDAO;

	@Override
	@Transactional
	public int insert(Purchase purchase) {
		int result = purchaseDAO.insert(purchase);
		System.out.println("price : " + purchase.getPrice());
		System.out.println("purchase : " + purchase);
 
		result = fundingDAO.updateStackPrice(purchase.getFundingCode(), purchase.getPrice()*purchase.getQty());
		System.out.println("result : " + result);
		
		return result;
	}
	
	@Override
	public List<Purchase> selectAll() {
		List<Purchase> list = purchaseDAO.selectAll();
		return list;
	}
	
	@Override
	public int countFundingCode(int fundingCode) {
		
		int result = purchaseDAO.countFundingCode(fundingCode);
		System.out.println("fundingcode service : " + result);
		return result;
	}
	
}