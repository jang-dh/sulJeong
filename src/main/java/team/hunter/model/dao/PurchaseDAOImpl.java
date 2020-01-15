package team.hunter.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	public List<Purchase> listDetail(int memberCode) {
		List<Purchase> list = session.selectList("purchaseMapper.listDetail", memberCode);
		return list;
	}

	@Override
	public int countFundingCode(int fundingCode) {
		int fundingSponserCount = session.selectOne("purchaseMapper.countFundingCode", fundingCode);
		return fundingSponserCount;
	}

	@Override
	public int updatePurchase(int code) {
		return session.update("purchaseMapper.purchaseFailedUpdate", code);
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
		map.put("memberCode", memberCode);
		Member member = session.selectOne("purchaseMapper.deliveryCodeSelect", map);
		return member;
	}

	@Override
	public int updatePurchaseState() {

		return session.update("purchaseMapper.updatePurchaseState");
	}

	@Override
	public int purchaseListCount(int memberCode) {
		return session.selectOne("purchaseMapper.purchaseListCount", memberCode);
	}

	@Override
	public List<Purchase> purchaseList(int memberCode, int startIndex, int cntPerPage){
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("memberCode", memberCode);
		map.put("startIndex", startIndex);
		map.put("cntPerPage", cntPerPage);
		return session.selectList("purchaseMapper.purchaseList", map);
	}

	@Override
	public List<Purchase> selectCanceled() {
		return session.selectList("purchaseMapper.canceled");
	}

	@Override
	public Purchase selectByCode(int code) {
		return session.selectOne("purchaseMapper.selectByCode", code);
	}
}
