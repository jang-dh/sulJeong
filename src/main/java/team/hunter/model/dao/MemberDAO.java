package team.hunter.model.dao;

import team.hunter.model.dto.Member;

public interface MemberDAO {

	/**
	 * 회원가입
	 * */
	int memberJoin(Member member);
}
