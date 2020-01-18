package team.hunter.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import team.hunter.model.dao.FundingDAO;
import team.hunter.model.dao.PurchaseDAO;
import team.hunter.model.dao.StatisticsDAO;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.Purchase;

@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	private PurchaseDAO purchaseDAO;

	@Autowired
	private FundingDAO fundingDAO;
	
	@Autowired
	private StatisticsDAO statisticsDAO;
	
	@Override
	@Transactional
	public int insert(Purchase purchase) {
		int result = purchaseDAO.insert(purchase);
		result = fundingDAO.updateStackPrice(purchase.getFundingCode(), purchase.getPrice());
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
	public int countPurchaseNumber(int memberCode) {
		return purchaseDAO.countPurchaseNumber(memberCode);
	}
	
	@Override
	public int countTotalPrice(int memberCode) {
		return purchaseDAO.countTotalPrice(memberCode);
	}

	@Override
	@Transactional
	public int updatePurchase(int code, int price) {
		System.out.println(code);
		int result = purchaseDAO.updatePurchase(code);
		Purchase purchase = purchaseDAO.selectByCode(code);
		System.out.println(purchase.getMerchantUid());
		cancelPurchase(purchase);
		statisticsDAO.updateFurchaseFailed(purchase.getPrice());
		fundingDAO.updateStackPrice(purchase.getFundingCode(), -1 * purchase.getPrice());
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
	public int updatePurchaseState() {
		return purchaseDAO.updatePurchaseState();
	}

	@Override
	public int purchaseListCount(int memberCode) {
		return purchaseDAO.purchaseListCount(memberCode);
	}

	@Override
	public List<Purchase> purchaseList(int memberCode, int startIndex, int cntPerPage) {
		List<Purchase> list = purchaseDAO.purchaseList(memberCode, startIndex, cntPerPage);
		if(list.get(0).getCode()==0) throw new RuntimeException();
		return list;
	}
	
	@Override
	public void cancelPurchase(Purchase purchase) {
		IamportClient iamportClient = new IamportClient("9641301071926320",
				"DGvvhuqgbRnvUxwBIwOoU5tDk5AH28ZGPvb7ZCnbtLHnjdZ1JOpETTieYSW11WIRrTYrvmCZ7jnqxnrh");
		CancelData cancelData = new CancelData(purchase.getMerchantUid(), false);

		try {
			IamportResponse<Payment> response = iamportClient.cancelPaymentByImpUid(cancelData);
			System.out.println("response.getCode() :" + response.getCode());
			System.out.println("response.getMessage() :" + response.getMessage());
			// System.out.println("response.getResponse().getAmount() :" +
			// response.getResponse().getAmount());
			// TODO : 처리 로직
		} catch (IamportResponseException e) {
			System.out.println(e.getMessage());

			switch (e.getHttpStatusCode()) {
			case 401:
				// TODO : 401 Unauthorized
				System.out.println(e.getMessage());
				break;
			case 404:
				// TODO : imp_123412341234 에 해당되는 거래내역이 존재하지 않음
				System.out.println(e.getMessage());
				break;
			case 500:
				// TODO : 서버 응답 오류
				System.out.println(e.getMessage());
				break;
			}
		} catch (IOException e) {
			// 서버 연결 실패
			e.printStackTrace();
		}
	}
}