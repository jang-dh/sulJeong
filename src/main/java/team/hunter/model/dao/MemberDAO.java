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
	
	/**
	 * 회원가입 메일 인증
	 * */
	void create(Member member) throws Exception;
	
	/**
	 * 회원가입 메일 인증 - 권한 키 업데이트
	 * */
	void updateAuthkey(Member member);
	
	/**
	 * 회원가입 메일 인증 - 권한 상태 업데이트
	 * */
	void updateAuthstatus(Member member);
}
