package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dao.PurchaseDAO;
import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Member;
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
		result = fundingDAO.updateStackPrice(purchase.getFundingCode(), purchase.getPrice()*purchase.getQty());
		return result;
	}
	
	@Override
	public List<Purchase> myPurchaseList(int memberCode) {
		List<Purchase> list = purchaseDAO.myPurchaseList(memberCode);
		
		System.out.println("서비스에서 찍은 : " + memberCode);
		System.out.println("서비스에서 찍은 : " + list);
		return list;
	}
	
	@Override
	public int countFundingCode(int fundingCode) {
		
		int result = purchaseDAO.countFundingCode(fundingCode);
		System.out.println("fundingcode service : " + result);
		return result;
	}
	
	@Override
	public int deletePurchaseList(int code) {
		int result = purchaseDAO.deleteList(code);
		return result;
	}

	@Override
	public int deliveryCodeSave(Purchase purchase) {
		int result = purchaseDAO.deliveryCodeSave(purchase);
		return result;
	}

	@Override
	public Member deliveryCodeSelect(int fundingCode, int memberCode) {
		Member member = purchaseDAO.deliveryCodeSelect(fundingCode, memberCode);
		return member;
	}
}