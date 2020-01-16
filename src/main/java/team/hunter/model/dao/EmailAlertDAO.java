package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.Member;

public interface EmailAlertDAO {
	
	/**
	 * 펀딩 성공 시 알림
	 * */
	public List<Funding> fundingSuccessAlert();
	
	/**
	 * 펀딩 실패 시 알림
	 * */
	public List<Funding> fundingFailAlert();
	
	/**
	 * 이메일 수신 동의 한 멤버 조회 - 펀딩 공지사항 - 공지사항 올라왔다 알림 시 사용
	 * */
	public List<Member> emailAcceptMember();
	
	/**
	 * 마감 하루 전 + 펀딩 한 사람 + 이메일 수신 동의 - 펀딩 마감임박 하루 전이다 알림
	 * */
	public List<Funding> fundingOneDayBefore();
	
	/**
	 * 마감 하루 전 + 좋아요 한 사람 + 이메일 수신 동의
	 * */
	public List<Funding> fundingOneDayBeforeLikes();
	
	
}
