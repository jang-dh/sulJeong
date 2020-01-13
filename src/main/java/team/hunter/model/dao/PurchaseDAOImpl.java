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
	public List<Purchase> listDetail(int memberCode) {
		List<Purchase> list = session.selectList("purchaseMapper.listDetail", memberCode);
		System.out.println("다오에서 리스트 나오냐");
		return list;
	}
	
	@Override
	public int countFundingCode(int fundingCode) {
		int fundingSponserCount = session.selectOne("purchaseMapper.countFundingCode", fundingCode);
		return fundingSponserCount;
	}
	
	@Override
	public int selectListByMemberCode(int code) {
		return session.selectOne("purchaseMapper.selectListByMemberCode", code);
		
	}
	
//	@Override
//	public List<Member> listDetail(int memberCode) {
//		
//		System.out.println("다오는 들어가니?");
//		List<Member>list = session.selectList("purchaseMapper.listDetail", memberCode);
//		
//		System.out.println("dao에서 보여주는 받는 사람 정보");
//		return list;
//	}
	
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
