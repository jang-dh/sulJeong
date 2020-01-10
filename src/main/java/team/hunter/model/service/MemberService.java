package team.hunter.model.service;

import java.util.List;

import team.hunter.model.dto.Member;

public interface MemberService {

	/**
	 * 회원가입
	 * */
	int memberJoin(Member member);
	
	List<Member> selectByPhone(Member member);
	
	Member selectMemberByCode(int memberCode);
	
	/**
	 * 비밀번호 이메일로 찾기
	 * */
	void newPassword(Member member) throws Exception;
	
	Member changeMyInfo(Member member);
	
	int membershipWithdrawal(Member member);

}
