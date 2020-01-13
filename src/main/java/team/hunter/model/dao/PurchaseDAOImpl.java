package team.hunter.model.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Member;
import team.hunter.model.dto.Purchase;


@Repository
public class PurchaseDAOImpl implements PurchaseDAO {
	
	@Autowired
	private SqlSession session;
	
	@Override
	public int insert(Purchase purchase) {
		return session.insert("purchaseMapper.insert", purchase);
	}
	
	@Override
	public List<Purchase> myPurchaseList(int memberCode) {
		List<Purchase> list = session.selectList("purchaseMapper.selectPurchaseByMemberCode", memberCode);
		return list;
	}
	
	@Override
	public int countFundingCode(int fundingCode) {
		int fundingSponserCount = session.selectOne("purchaseMapper.countFundingCode", fundingCode);
		return fundingSponserCount;
	}
	
	@Override
	public Funding recipientInformation(int fundingCode) {
		Funding funding = session.selectOne("purchaseMapper.recipientInformation", fundingCode);
		return funding;
	}
	
	@Override
	public int deleteList(int code) {
		return session.delete("purchaseMapper.delete", code);
	}

	@Override
	public int deliveryCodeSave(Purchase purchase) {
		int result = session.insert("purchaseMapper.deliveryCodeUpdate", purchase);
		return result;
	}

	@Override
	public Member deliveryCodeSelect(int fundingCode, int memberCode) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("fundingCode", fundingCode);
		map.put("memberCode",memberCode);
		Member member = session.selectOne("purchaseMapper.deliveryCodeSelect", map);
		return member;
	}
}
