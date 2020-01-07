package team.hunter.model.dao;

import team.hunter.model.dto.Member;

public interface MemberDAO {
	
	Member selectMemberById(String id);
	
	/**
	 * 회원가입
	 * */
	int memberJoin(Member member);
	
	Member selectByPhone(Member member);

}
