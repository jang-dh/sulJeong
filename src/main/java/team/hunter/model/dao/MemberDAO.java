package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Member;

public interface MemberDAO {
	
	Member selectMemberByCode(int memberCode);
	
	Member selectMemberById(String id);
	
	/**
	 * 회원가입
	 * */
	int memberJoin(Member member);
	
	List<Member> selectByPhone(Member member);

	
	/**
	 * 비밀번호 이메일로 찾기
	 * */
	int newPassword(Member member) throws Exception;
	
	int changeMyInfo(Member member);
	
	int membershipWithdrawal(Member member);
	
	Member idDuplicateCheck(String id);
	
}
