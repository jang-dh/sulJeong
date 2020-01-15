package team.hunter.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dao.PurchaseDAO;
import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;
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
	public List<Purchase> listDetail(int memberCode) {
		List<Purchase> list = purchaseDAO.listDetail(memberCode);
		return list;
	}
	
	@Override
	public int countFundingCode(int fundingCode) {
		int result = purchaseDAO.countFundingCode(fundingCode);
		return result;
	}
	
	@Override
	public int updatePurchase(int code) {
		int result = purchaseDAO.updatePurchase(code);
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
	
	@Override
	public int purchaseListCount(int memberCode) {
		return purchaseDAO.purchaseListCount(memberCode);
	}
	
	@Override
	public List<Purchase> purchaseList(int memberCode, int startIndex, int cntPerPage) {
		return purchaseDAO.purchaseList(memberCode, startIndex, cntPerPage);
	}
}