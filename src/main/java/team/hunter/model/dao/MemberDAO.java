package team.hunter.model.dao;

import team.hunter.model.dto.Member;

public interface MemberDAO {
	
	Member selectMemberById(String id);
	
	/**
	 * 회원가입
	 * */
	int memberJoin(Member member);
	
	Member selectByPhone(Member member);

	
	/**
	 * 비밀번호 이메일로 찾기
	 * */
	void newPassword(Member member) throws Exception;
	
	int changeMyInfo(Member member);
	
	int membershipWithdrawal(Member member);
}
