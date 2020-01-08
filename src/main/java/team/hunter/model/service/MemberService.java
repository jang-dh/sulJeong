package team.hunter.model.service;

import team.hunter.model.dto.Member;

public interface MemberService {

	/**
	 * 회원가입
	 * */
	int memberJoin(Member member);
	
	Member selectByPhone(Member member);
	
	/**
	 * 비밀번호 이메일로 찾기
	 * */
	void newPassword(Member member) throws Exception;

}
