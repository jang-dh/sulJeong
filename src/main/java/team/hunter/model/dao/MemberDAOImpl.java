package team.hunter.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public Member selectMemberByCode(int memberCode) {
		return session.selectOne("memberMapper.selectMemberByCode", memberCode);
		
	}

	@Override
	public int memberJoin(Member member) {
		int result = session.insert("memberMapper.memberJoin",member);
		return result;

	}

	@Override
	public List<Member> selectByPhone(Member member) {
		return session.selectList("memberMapper.selectByPhone",member);
	}

	@Override
	public int newPassword(Member member) throws Exception {
		String password = member.getPwd();
		member.setPwd(password);
		int result = session.update("memberMapper.newPassword", member);
		return result;
	}

	@Override
	public int changeMyInfo(Member member) {
		return session.update("memberMapper.changeMyInfo", member);
	}

	@Override
	public int membershipWithdrawal(Member member) {
		return session.delete("memberMapper.membershipWithdrawal", member);
	}

	@Override
	public Member selectMemberById(String id) {
		return session.selectOne("memberMapper.selectMemberById", id);
	}

	@Override
	public Member idDuplicateCheck(String id) {
		return session.selectOne("memberMapper.idDuplicateCheck", id);
	}

//	@Override
//	public void create(Member member) throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	
//	@Override
//	public void updateAuthkey(Member member) {
//		// TODO Auto-generated method stub
//		
//	}
//	
//	
//	@Override
//	public void updateAuthstatus(Member member) {
//		// TODO Auto-generated method stub
//		
//	}

	
}
