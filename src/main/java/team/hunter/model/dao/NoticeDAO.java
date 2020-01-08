package team.hunter.model.dao;

import java.util.List;

import team.hunter.model.dto.Funding;
import team.hunter.model.dto.FundingRequest;
import team.hunter.model.dto.Notice;

public interface NoticeDAO {
	/**
	* ��ü���
	 * */
	Notice selectByCode(int code);
	
	/**
	* �󼼺���
	 * */
	List<Notice> select();
		
	/**
	* ���
	* */
	int insert(Notice dto);
		
	/**
	* ����
	* */
	int delete(int code);
	
	/**
	 * �Խù� ����
	 * */
	int update(Notice code);
	
	/**
	 * 펀딩 등록 전에 
	 * 펀딩신청자 목록 가지고 오기
	 * */
	List<FundingRequest> selectFundingRequest();

	/**
	 * 펀딩 등록하기
	 * */
	int fundInsert(Funding funding);
}
