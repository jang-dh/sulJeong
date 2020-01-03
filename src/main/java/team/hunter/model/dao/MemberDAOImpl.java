package team.hunter.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import team.hunter.model.dto.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession session;
	
	@Override
	public Member selectMemberById(String id) {
		
		return session.selectOne("memberMapper.selectMemberById", id);

	@Override
	public int memberJoin(Member member) {
		int result = session.insert("memberMapper.memberJoin",member);
		return result;

	}

}
